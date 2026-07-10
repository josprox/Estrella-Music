import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

/// Pure Dart implementation of the Shazam audio fingerprinting algorithm.
/// Ported from the vibra C++ library which implements the Shazam signature algorithm.
class ShazamSignatureGenerator {
  static const int sampleRate = 16000;
  static const int fftSize = 2048;
  static const int fftOutputSize = fftSize ~/ 2 + 1; // 1025
  static const int maxPeaks = 255;
  static const double maxTimeSeconds = 12.0;
  static const int ringBufSize = 256;

  static const int band250To520 = 0;
  static const int band520To1450 = 1;
  static const int band1450To3500 = 2;
  static const int band3500To5500 = 3;

  /// Hanning window: w[i] = 0.5 * (1 - cos(2π*(i+1)/2049)) for i=0..2047.
  static final List<double> _hanning = List<double>.generate(
    fftSize,
    (i) => 0.5 * (1.0 - math.cos(2.0 * math.pi * (i + 1) / 2049.0)),
  );

  /// Generates a Shazam-compatible audio fingerprint from raw 16-bit PCM samples.
  ///
  /// [samples] mono PCM audio (16-bit signed little-endian, 16kHz)
  /// Returns signature URI string (data:audio/vnd.shazam.sig;base64,...)
  static String fromI16(Int16List samples) {
    return _SignatureGeneratorState().process(samples);
  }
}

class _FrequencyPeak {
  final int fftPassNumber;
  final int peakMagnitude;
  final int correctedPeakFrequencyBin;

  _FrequencyPeak({
    required this.fftPassNumber,
    required this.peakMagnitude,
    required this.correctedPeakFrequencyBin,
  });
}

class _SignatureGeneratorState {
  // Circular buffer for 2048 raw samples
  final Int32List samplesRing = Int32List(ShazamSignatureGenerator.fftSize);
  int samplesPos = 0;

  // Circular buffer of FFT magnitude outputs (RING_BUF_SIZE x FFT_OUTPUT_SIZE)
  final List<Float64List> fftOutputs = List<Float64List>.generate(
    ShazamSignatureGenerator.ringBufSize,
    (_) => Float64List(ShazamSignatureGenerator.fftOutputSize),
  );
  int fftPos = 0;
  int fftNumWritten = 0;

  // Circular buffer of time-spread FFT outputs (RING_BUF_SIZE x FFT_OUTPUT_SIZE)
  final List<Float64List> spreadFfts = List<Float64List>.generate(
    ShazamSignatureGenerator.ringBufSize,
    (_) => Float64List(ShazamSignatureGenerator.fftOutputSize),
  );
  int spreadPos = 0;
  int spreadNumWritten = 0;

  // Accumulated samples count
  int numSamples = 0;

  // Band -> list of peaks (bands 0..3)
  final List<List<_FrequencyPeak>> bandPeaks = List<List<_FrequencyPeak>>.generate(
    4,
    (_) => <_FrequencyPeak>[],
  );
  int totalPeaks = 0;

  String process(Int16List pcm) {
    int offset = 0;
    while (offset + 128 <= pcm.length) {
      final elapsedSec = numSamples / ShazamSignatureGenerator.sampleRate;
      if (elapsedSec >= ShazamSignatureGenerator.maxTimeSeconds &&
          totalPeaks >= ShazamSignatureGenerator.maxPeaks) {
        break;
      }

      numSamples += 128;
      feedSamples(pcm, offset, 128);
      doFFT();
      doPeakSpreadingAndRecognition();
      offset += 128;
    }
    return encodeSignature();
  }

  void feedSamples(Int16List pcm, int start, int count) {
    for (int k = start; k < start + count; k++) {
      samplesRing[samplesPos] = pcm[k];
      samplesPos = (samplesPos + 1) % ShazamSignatureGenerator.fftSize;
    }
  }

  void doFFT() {
    final windowed = Float64List(ShazamSignatureGenerator.fftSize);
    for (int i = 0; i < ShazamSignatureGenerator.fftSize; i++) {
      windowed[i] = samplesRing[(samplesPos + i) % ShazamSignatureGenerator.fftSize].toDouble() *
          ShazamSignatureGenerator._hanning[i];
    }
    final result = computeRfft(windowed);
    fftOutputs[fftPos].setAll(0, result);
    fftPos = (fftPos + 1) % ShazamSignatureGenerator.ringBufSize;
    fftNumWritten++;
  }

  void doPeakSpreadingAndRecognition() {
    doPeakSpreading();
    if (spreadNumWritten >= 47) {
      doPeakRecognition();
    }
  }

  void doPeakSpreading() {
    final lastFftIdx = (fftPos - 1 + ShazamSignatureGenerator.ringBufSize) % ShazamSignatureGenerator.ringBufSize;
    final spread = Float64List.fromList(fftOutputs[lastFftIdx]);

    for (int pos = 0; pos < ShazamSignatureGenerator.fftOutputSize - 2; pos++) {
      spread[pos] = math.max(spread[pos], math.max(spread[pos + 1], spread[pos + 2]));
    }

    for (int pos = 0; pos < ShazamSignatureGenerator.fftOutputSize; pos++) {
      double maxVal = spread[pos];
      for (int offset in const [-1, -3, -6]) {
        final idx = ((spreadPos + offset) % ShazamSignatureGenerator.ringBufSize + ShazamSignatureGenerator.ringBufSize) % ShazamSignatureGenerator.ringBufSize;
        final oldVal = spreadFfts[idx][pos];
        if (oldVal > maxVal) maxVal = oldVal;
        spreadFfts[idx][pos] = maxVal;
      }
    }

    spreadFfts[spreadPos].setAll(0, spread);
    spreadPos = (spreadPos + 1) % ShazamSignatureGenerator.ringBufSize;
    spreadNumWritten++;
  }

  void doPeakRecognition() {
    final fftMinus46 = fftOutputs[(fftPos - 46 + ShazamSignatureGenerator.ringBufSize * 2) % ShazamSignatureGenerator.ringBufSize];
    final spreadMinus49 = spreadFfts[(spreadPos - 49 + ShazamSignatureGenerator.ringBufSize * 2) % ShazamSignatureGenerator.ringBufSize];

    const otherOffsets = [-53, -45, 165, 172, 179, 186, 193, 200, 214, 221, 228, 235, 242, 249];

    for (int binPos = 10; binPos < ShazamSignatureGenerator.fftOutputSize - 8; binPos++) {
      final fftVal = fftMinus46[binPos];
      if (fftVal < 1.0 / 64.0 || fftVal < spreadMinus49[binPos]) continue;

      double maxNeighborSpread49 = 0.0;
      for (int neighborOffset in const [-10, -7, -4, -3, 1, 2, 5, 8]) {
        final v = spreadMinus49[binPos + neighborOffset];
        if (v > maxNeighborSpread49) maxNeighborSpread49 = v;
      }
      if (fftVal <= maxNeighborSpread49) continue;

      double maxNeighborOther = maxNeighborSpread49;
      for (int otherOffset in otherOffsets) {
        final spreadIdx = ((spreadPos + otherOffset) % ShazamSignatureGenerator.ringBufSize + ShazamSignatureGenerator.ringBufSize) % ShazamSignatureGenerator.ringBufSize;
        final v = spreadFfts[spreadIdx][binPos - 1];
        if (v > maxNeighborOther) maxNeighborOther = v;
      }
      if (fftVal <= maxNeighborOther) continue;

      final fftNumber = spreadNumWritten - 46;

      final peakMag = math.log(math.max(1.0 / 64.0, fftVal)) * 1477.3 + 6144;
      final peakMagBefore = math.log(math.max(1.0 / 64.0, fftMinus46[binPos - 1])) * 1477.3 + 6144;
      final peakMagAfter = math.log(math.max(1.0 / 64.0, fftMinus46[binPos + 1])) * 1477.3 + 6144;

      final peakVariation1 = peakMag * 2 - peakMagBefore - peakMagAfter;
      final peakVariation2 = (peakMagAfter - peakMagBefore) * 32 / peakVariation1;

      final correctedBin = binPos * 64.0 + peakVariation2;
      final frequencyHz = correctedBin * (16000.0 / 2.0 / 1024.0 / 64.0);

      int band;
      if (frequencyHz < 250.0) {
        continue;
      } else if (frequencyHz < 520.0) {
        band = ShazamSignatureGenerator.band250To520;
      } else if (frequencyHz < 1450.0) {
        band = ShazamSignatureGenerator.band520To1450;
      } else if (frequencyHz < 3500.0) {
        band = ShazamSignatureGenerator.band1450To3500;
      } else if (frequencyHz <= 5500.0) {
        band = ShazamSignatureGenerator.band3500To5500;
      } else {
        continue;
      }

      bandPeaks[band].add(
        _FrequencyPeak(
          fftPassNumber: fftNumber,
          peakMagnitude: peakMag.toInt(),
          correctedPeakFrequencyBin: correctedBin.toInt(),
        ),
      );
      totalPeaks++;
    }
  }

  String encodeSignature() {
    final contentsStream = <int>[];

    for (int bandId = 0; bandId <= 3; bandId++) {
      final peaks = bandPeaks[bandId];
      if (peaks.isEmpty) continue;

      final peakBuf = <int>[];
      int prevFftPassNumber = 0;

      for (var peak in peaks) {
        final diff = peak.fftPassNumber - prevFftPassNumber;
        if (diff >= 255) {
          peakBuf.add(0xFF);
          writeLittleEndian32(peakBuf, peak.fftPassNumber);
          prevFftPassNumber = peak.fftPassNumber;
        }
        peakBuf.add(peak.fftPassNumber - prevFftPassNumber);
        writeLittleEndian16(peakBuf, peak.peakMagnitude);
        writeLittleEndian16(peakBuf, peak.correctedPeakFrequencyBin);
        prevFftPassNumber = peak.fftPassNumber;
      }

      writeLittleEndian32(contentsStream, 0x60030040 + bandId);
      writeLittleEndian32(contentsStream, peakBuf.length);
      contentsStream.addAll(peakBuf);

      final padBytes = (4 - peakBuf.length % 4) % 4;
      for (int p = 0; p < padBytes; p++) {
        contentsStream.add(0);
      }
    }

    final sizeMinusHeader = contentsStream.length + 8;
    final samplesAndOffset = (numSamples + ShazamSignatureGenerator.sampleRate * 0.24).toInt();

    final headerBytes = ByteData(48);
    headerBytes.setInt32(0, 0xcafe2580, Endian.little); // magic1
    headerBytes.setInt32(4, 0, Endian.little);          // crc32 placeholder
    headerBytes.setInt32(8, sizeMinusHeader, Endian.little); // size_minus_header
    headerBytes.setInt32(12, 0x94119c00.toInt(), Endian.little); // magic2
    headerBytes.setInt32(16, 0, Endian.little);
    headerBytes.setInt32(20, 0, Endian.little);
    headerBytes.setInt32(24, 0, Endian.little);
    headerBytes.setInt32(28, 3 << 27, Endian.little);  // shifted_sample_rate_id
    headerBytes.setInt32(32, 0, Endian.little);
    headerBytes.setInt32(36, 0, Endian.little);
    headerBytes.setInt32(40, samplesAndOffset, Endian.little);
    headerBytes.setInt32(44, (15 << 19) + 0x40000, Endian.little);

    final fullBuf = <int>[];
    fullBuf.addAll(headerBytes.buffer.asUint8List());
    writeLittleEndian32(fullBuf, 0x40000000);
    writeLittleEndian32(fullBuf, contentsStream.length + 8);
    fullBuf.addAll(contentsStream);

    final crc32Value = Crc32.compute(fullBuf, 8, fullBuf.length);

    // Update crc32 placeholder in fullBuf (indices 4..7)
    final crcBytes = ByteData(4);
    crcBytes.setInt32(0, crc32Value, Endian.little);
    fullBuf[4] = crcBytes.getUint8(0);
    fullBuf[5] = crcBytes.getUint8(1);
    fullBuf[6] = crcBytes.getUint8(2);
    fullBuf[7] = crcBytes.getUint8(3);

    final base64String = base64.encode(fullBuf);
    return "data:audio/vnd.shazam.sig;base64,$base64String";
  }

  void writeLittleEndian32(List<int> out, int value) {
    out.add(value & 0xFF);
    out.add((value >>> 8) & 0xFF);
    out.add((value >>> 16) & 0xFF);
    out.add((value >>> 24) & 0xFF);
  }

  void writeLittleEndian16(List<int> out, int value) {
    out.add(value & 0xFF);
    out.add((value >>> 8) & 0xFF);
  }

  Float64List computeRfft(Float64List windowed) {
    final n = windowed.length; // 2048
    final re = Float64List.fromList(windowed);
    final im = Float64List(n);

    int j = 0;
    for (int i = 1; i < n; i++) {
      int bit = n >>> 1;
      while ((j & bit) != 0) {
        j = j ^ bit;
        bit = bit >>> 1;
      }
      j = j ^ bit;
      if (i < j) {
        final tmpRe = re[i]; re[i] = re[j]; re[j] = tmpRe;
        final tmpIm = im[i]; im[i] = im[j]; im[j] = tmpIm;
      }
    }

    int len = 2;
    while (len <= n) {
      final halfLen = len >>> 1;
      final ang = -math.pi / halfLen;
      final wBaseRe = math.cos(ang);
      final wBaseIm = math.sin(ang);
      int i = 0;
      while (i < n) {
        double wRe = 1.0;
        double wIm = 0.0;
        for (int k = 0; k < halfLen; k++) {
          final u = i + k;
          final v = u + halfLen;
          final evenRe = re[u];
          final evenIm = im[u];
          final oddRe = re[v] * wRe - im[v] * wIm;
          final oddIm = re[v] * wIm + im[v] * wRe;
          re[u] = evenRe + oddRe;
          im[u] = evenIm + oddIm;
          re[v] = evenRe - oddRe;
          im[v] = evenIm - oddIm;
          final newWRe = wRe * wBaseRe - wIm * wBaseIm;
          wIm = wRe * wBaseIm + wIm * wBaseRe;
          wRe = newWRe;
        }
        i += len;
      }
      len = len << 1;
    }

    const scaleFactor = 1.0 / (1 << 17);
    const minVal = 1e-10;
    final out = Float64List(ShazamSignatureGenerator.fftOutputSize);
    for (int idx = 0; idx < ShazamSignatureGenerator.fftOutputSize; idx++) {
      final r = re[idx];
      final img = im[idx];
      final mag = (r * r + img * img) * scaleFactor;
      out[idx] = mag < minVal ? minVal : mag;
    }
    return out;
  }
}

class Crc32 {
  static final List<int> _table = List<int>.generate(256, (i) {
    int c = i;
    for (int k = 0; k < 8; k++) {
      if ((c & 1) != 0) {
        c = 0xedb88320 ^ (c >>> 1);
      } else {
        c = c >>> 1;
      }
    }
    return c;
  });

  static int compute(List<int> bytes, [int start = 0, int? end]) {
    int crc = 0xffffffff;
    final int stop = end ?? bytes.length;
    for (int i = start; i < stop; i++) {
      crc = _table[(crc ^ bytes[i]) & 0xff] ^ (crc >>> 8);
    }
    return crc ^ 0xffffffff;
  }
}
