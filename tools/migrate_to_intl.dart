// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

void main() {
  final inputDir = Directory('localization');
  final outputDir = Directory('lib/l10n');

  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  final files = inputDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.json'));

  for (var file in files) {
    if (file.path.contains('generator.dart')) continue;

    final fileName = file.uri.pathSegments.last;
    String locale = fileName.split('.').first;

    // Handle special cases from generator.dart
    if (locale == "zh_Hant") {
      locale = "zh_TW";
    } else if (locale == "zh_Hans") {
      locale = "zh_CN";
    }

    print('Converting $fileName to intl_$locale.arb...');

    final content = file.readAsStringSync();
    final Map<String, dynamic> json = jsonDecode(content);
    final Map<String, dynamic> arb = {
      '@@locale': locale,
    };

    json.forEach((key, value) {
      // Clean up keys to be valid Dart identifiers
      String newKey =
          key.replaceAll('&', 'And').replaceAll(' ', '_').replaceAll('-', '_');
      // Ensure it doesn't start with a number
      if (RegExp(r'^\d').hasMatch(newKey)) {
        newKey = 'v$newKey';
      }
      arb[newKey] = value;
    });

    final arbFile = File('${outputDir.path}/intl_$locale.arb');
    arbFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(arb));
  }

  print('Migration complete! ARB files generated in ${outputDir.path}');
}
