import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:get/get.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:estrella_music/utils/helpers/helper.dart';
import 'package:estrella_music/services/sync/music_sqlite_service.dart';

class AppBackupService extends GetxService {
  Future<String> get supportDirPath async {
    return (await getApplicationSupportDirectory()).path;
  }

  Future<void> runAutomaticBackupIfNeeded() async {
    // Disabled upload backups in cloud migration
    return;
  }

  Future<String> get databaseDirPath async {
    if (GetPlatform.isDesktop) {
      return '${await supportDirPath}/db';
    }
    return (await getApplicationDocumentsDirectory()).path;
  }

  Future<List<String>> collectFilesToBackup() async {
    try {
      SqliteStore.checkpoint();
    } catch (e) {
      printERROR('Error checkpointing SqliteStore: $e');
    }
    if (Get.isRegistered<MusicSqliteService>()) {
      try {
        Get.find<MusicSqliteService>().checkpoint();
      } catch (e) {
        printERROR('Error checkpointing MusicSqliteService: $e');
      }
    }
    final files = <String>[];
    final databaseDirectories = <String>{
      await databaseDirPath,
      '${await supportDirPath}/db',
      await supportDirPath,
    };
    for (final path in databaseDirectories) {
      final dbDir = Directory(path);
      if (await dbDir.exists()) {
        await for (final entity in dbDir.list(recursive: false)) {
          if (entity is File) {
            final fileName = p.basename(entity.path);
            if (fileName.endsWith('.sqlite3') ||
                fileName.endsWith('.sqlite3-wal') ||
                fileName.endsWith('.sqlite3-shm') ||
                fileName.endsWith('.hive')) {
              files.add(entity.path);
            }
          }
        }
      }
    }

    final thumbsDir = Directory('${await supportDirPath}/thumbnails');
    if (await thumbsDir.exists()) {
      await for (final entity in thumbsDir.list(recursive: false)) {
        if (entity is File && entity.path.endsWith('.png')) {
          files.add(entity.path);
        }
      }
    }

    return files.toSet().toList();
  }

  Future<File> createBackupArchive({
    required String outputPath,
  }) async {
    final outputFile = File(outputPath);
    if (await outputFile.exists()) {
      await outputFile.delete();
    }
    await outputFile.parent.create(recursive: true);

    final encoder = ZipFileEncoder();
    encoder.create(outputPath);

    final files = await collectFilesToBackup();

    for (final filePath in files) {
      final file = File(filePath);
      if (!await file.exists()) {
        continue;
      }
      encoder.addFile(file, p.basename(file.path));
    }

    encoder.close();
    return outputFile;
  }

  Future<Uint8List> createBackupBytes() async {
    final tempDir = await getTemporaryDirectory();
    final archiveFile = await createBackupArchive(
      outputPath:
          '${tempDir.path}/estrella_${DateTime.now().millisecondsSinceEpoch}.hmb',
    );
    try {
      return await archiveFile.readAsBytes();
    } finally {
      if (await archiveFile.exists()) {
        await archiveFile.delete();
      }
    }
  }

  Future<File> createTemporaryBackupArchive() async {
    final tempDir = await getTemporaryDirectory();
    return createBackupArchive(
      outputPath:
          '${tempDir.path}/estrella_${DateTime.now().millisecondsSinceEpoch}.hmb',
    );
  }

  Future<File> createRecoveryBackupArchive() async {
    final backupDirectory =
        Directory(p.join(await supportDirPath, 'recovery_backups'));
    await backupDirectory.create(recursive: true);
    return createBackupArchive(
      outputPath: p.join(
        backupDirectory.path,
        'before_cloud_replace_${DateTime.now().millisecondsSinceEpoch}.hmb',
      ),
    );
  }

  Future<void> restoreBackupFile(String filePath) async {
    await restoreBackupBytes(await File(filePath).readAsBytes());
  }

  Future<void> restoreBackupBytes(
    Uint8List bytes, {
    bool reopenCoreBoxes = false,
    bool clearExistingMediaAssets = false,
  }) async {
    final dbDirPath = await databaseDirPath;
    final dbDir = Directory(dbDirPath);
    final appSupportDir = await supportDirPath;

    await SqliteStore.close();
    final musicDatabase = Get.isRegistered<MusicSqliteService>()
        ? Get.find<MusicSqliteService>()
        : null;
    await musicDatabase?.closeDatabase();

    if (clearExistingMediaAssets) {
      await _clearDirectoryContents(Directory('$appSupportDir/Music'));
      await _clearDirectoryContents(Directory('$appSupportDir/thumbnails'));
      await _clearCachedSongs();
    }

    final databaseDirectories = <Directory>{
      dbDir,
      Directory('$appSupportDir/db'),
    };
    for (final directory in databaseDirectories) {
      if (await directory.exists()) {
        await for (final entity in directory.list(recursive: false)) {
          if (entity is File &&
              (entity.path.endsWith('.sqlite3') ||
                  entity.path.endsWith('.sqlite3-wal') ||
                  entity.path.endsWith('.sqlite3-shm') ||
                  entity.path.endsWith('.hive'))) {
            await entity.delete();
          }
        }
      }
    }

    final archive = ZipDecoder().decodeBytes(bytes);
    for (final archivedFile in archive) {
      if (!archivedFile.isFile) {
        continue;
      }

      final fileName = archivedFile.name;
      final content = archivedFile.content as List<int>;
      final targetDirectory =
          _targetDirectoryForRestoredFile(fileName, dbDirPath, appSupportDir);
      final outputFile = File('$targetDirectory/$fileName');
      await outputFile.parent.create(recursive: true);
      await outputFile.writeAsBytes(content, flush: true);
    }

    await SqliteStore.initialize(dbDirPath);
    await musicDatabase?.initialize();

    if (GetPlatform.isWindows || GetPlatform.isLinux) {
      final songDownloadsBox = await SqliteStore.openBox('SongDownloads');
      for (final key in songDownloadsBox.keys.toList()) {
        final song = songDownloadsBox.get(key);
        if (song is! Map) {
          continue;
        }
        final songPath = song['url']?.toString();
        if (songPath == null || songPath.isEmpty) {
          continue;
        }

        final fileName = p.basename(songPath);
        final newFilePath = '$appSupportDir/Music/$fileName';
        song['url'] = newFilePath;
        if (song['streamInfo'] is List &&
            (song['streamInfo'] as List).length > 1) {
          final streamInfo = song['streamInfo'] as List;
          if (streamInfo[1] is Map) {
            streamInfo[1]['url'] = newFilePath;
          }
        }
        await songDownloadsBox.put(key, song);
      }
      await songDownloadsBox.close();
    }

    if (reopenCoreBoxes) {
      await ensureCoreBoxesOpen();

      // EMusicProvider reads restored visitor data lazily from AppPrefs when
      // resolving playback, so no concrete catalog service is refreshed here.
    }
  }

  Future<void> clearLocalMusicData() async {
    final boxNames = await _collectMusicBoxNames();
    for (final boxName in boxNames) {
      await _deleteBoxFromDisk(boxName);
    }

    final appSupportDir = await supportDirPath;
    await _clearDirectoryContents(Directory('$appSupportDir/Music'));
    await _clearDirectoryContents(Directory('$appSupportDir/thumbnails'));
    await _clearCachedSongs();
    await ensureCoreBoxesOpen();
  }

  Future<void> ensureCoreBoxesOpen() async {
    if (!SqliteStore.isBoxOpen('SongsCache')) {
      await SqliteStore.openBox('SongsCache');
    }
    if (!SqliteStore.isBoxOpen('SongDownloads')) {
      await SqliteStore.openBox('SongDownloads');
    }
    if (!SqliteStore.isBoxOpen('SongsUrlCache')) {
      await SqliteStore.openBox('SongsUrlCache');
    }
    if (!SqliteStore.isBoxOpen('AppPrefs')) {
      await SqliteStore.openBox('AppPrefs');
    }
    if (!SqliteStore.isBoxOpen('LIBFAV')) {
      await SqliteStore.openBox('LIBFAV');
    }
    if (!SqliteStore.isBoxOpen('LIBRP')) {
      await SqliteStore.openBox('LIBRP');
    }
    if (!SqliteStore.isBoxOpen('LibraryArtists')) {
      await SqliteStore.openBox('LibraryArtists');
    }
    if (!SqliteStore.isBoxOpen('LibraryAlbums')) {
      await SqliteStore.openBox('LibraryAlbums');
    }
    if (!SqliteStore.isBoxOpen('LibraryPlaylists')) {
      await SqliteStore.openBox('LibraryPlaylists');
    }
    if (!SqliteStore.isBoxOpen('homeScreenData')) {
      await SqliteStore.openBox('homeScreenData');
    }
    if (!SqliteStore.isBoxOpen('PendingSyncChanges')) {
      await SqliteStore.openBox('PendingSyncChanges');
    }
  }

  String _targetDirectoryForRestoredFile(
    String fileName,
    String dbDirPath,
    String supportDir,
  ) {
    if (fileName.endsWith('.m4a') ||
        fileName.endsWith('.opus') ||
        fileName.endsWith('.mp3')) {
      return '$supportDir/Music';
    }
    if (fileName.endsWith('.png')) {
      return '$supportDir/thumbnails';
    }
    if (fileName.startsWith(MusicSqliteService.databaseFileName)) {
      return '$supportDir/db';
    }
    return dbDirPath;
  }

  Future<Set<String>> _collectMusicBoxNames() async {
    final boxNames = <String>{
      'LibraryPlaylists',
      'LibraryAlbums',
      'LibraryArtists',
      'LIBFAV',
      'LIBRP',
      'SongsCache',
      'SongDownloads',
      'SongsUrlCache',
      'prevSessionData',
    };

    boxNames.addAll(await _readBoxKeys('LibraryPlaylists'));
    boxNames.addAll(await _readBoxKeys('LibraryAlbums'));
    return boxNames.where((name) => name.trim().isNotEmpty).toSet();
  }

  Future<Set<String>> _readBoxKeys(String boxName) async {
    SqliteBox<dynamic>? box;
    final wasOpen = SqliteStore.isBoxOpen(boxName);
    try {
      box = wasOpen
          ? SqliteStore.box(boxName)
          : await SqliteStore.openBox(boxName);
      return box.keys
          .map((key) => key.toString().trim())
          .where((key) => key.isNotEmpty)
          .toSet();
    } finally {
      if (!wasOpen && box != null && box.isOpen) {
        await box.close();
      }
    }
  }

  Future<void> _deleteBoxFromDisk(String boxName) async {
    try {
      final box = SqliteStore.isBoxOpen(boxName)
          ? SqliteStore.box(boxName)
          : await SqliteStore.openBox(boxName);
      await box.deleteFromDisk();
    } catch (e) {
      printERROR('No fue posible borrar la coleccion $boxName: $e');
    }
  }

  Future<void> _clearCachedSongs() async {
    final tempDir = await getTemporaryDirectory();
    await _clearDirectoryContents(Directory('${tempDir.path}/cachedSongs'));
  }

  Future<void> _clearDirectoryContents(Directory directory) async {
    if (!await directory.exists()) {
      return;
    }

    await for (final entity in directory.list(recursive: false)) {
      try {
        await entity.delete(recursive: true);
      } catch (e) {
        printERROR('No fue posible borrar ${entity.path}: $e');
      }
    }
  }

  Future<void> safeDelete(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      printERROR('No fue posible borrar temporal ${file.path}: $e');
    }
  }
}
