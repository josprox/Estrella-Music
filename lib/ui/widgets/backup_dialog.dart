import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widgets/loader.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/services/system/permission_service.dart';
import 'common_dialog_widget.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:share_plus/share_plus.dart';
import 'package:harmonymusic/services/backup/app_backup_service.dart';

class BackupDialog extends StatelessWidget {
  const BackupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final backupDialogController = Get.put(BackupDialogController());
    return CommonDialog(
      child: Container(
        height: GetPlatform.isAndroid ? 350 : 300,
        padding:
            const EdgeInsets.only(top: 20, bottom: 30, left: 20, right: 20),
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                child: Text(
                  S.current.backupAppData,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => (backupDialogController.scanning.isTrue ||
                              backupDialogController.backupRunning.isTrue)
                          ? const LoadingIndicator()
                          : const SizedBox.shrink()),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Obx(() => Text(
                                backupDialogController
                                        .errorMessage.value.isNotEmpty
                                    ? backupDialogController.errorMessage.value
                                    : backupDialogController.scanning.isTrue
                                        ? S.current.scanning
                                        : backupDialogController
                                                .backupRunning.isTrue
                                            ? S.current.backupInProgress
                                            : backupDialogController
                                                    .isbackupCompleted.isTrue
                                                ? S.current.backupMsg
                                                : S.current.letsStrart,
                                textAlign: TextAlign.center,
                                style: backupDialogController
                                        .errorMessage.value.isNotEmpty
                                    ? const TextStyle(color: Colors.redAccent)
                                    : null,
                              )),
                        ],
                      )
                    ],
                  )),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: double.maxFinite,
                child: Align(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).textTheme.titleLarge!.color,
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        if (backupDialogController.isbackupCompleted.isTrue) {
                          Navigator.of(context).pop();
                        } else {
                          backupDialogController.backup();
                        }
                      },
                      child: Obx(
                        () => Visibility(
                          visible:
                              !(backupDialogController.backupRunning.isTrue ||
                                  backupDialogController.scanning.isTrue),
                          replacement: const SizedBox(
                            height: 40,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10),
                            child: Obx(
                              () => Text(
                                backupDialogController.isbackupCompleted.isTrue
                                    ? S.current.close
                                    : S.current.backup,
                                style: TextStyle(
                                    color: Theme.of(context).canvasColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class BackupDialogController extends GetxController {
  final scanning = false.obs;
  final isbackupCompleted = false.obs;
  final backupRunning = false.obs;
  final errorMessage = ''.obs;
  List<String> filesToExport = [];

  Future<void> scanFilesToBackup() async {
    filesToExport = await Get.find<AppBackupService>().collectFilesToBackup();
  }

  Future<void> backup() async {
    errorMessage.value = '';
    String? pickedFolderPath;

    if (!GetPlatform.isAndroid) {
      if (!await PermissionService.getExtStoragePermission()) {
        return;
      }

      pickedFolderPath = await FilePicker.platform
          .getDirectoryPath(dialogTitle: S.current.backup_select_folder_dialog);
      if (pickedFolderPath == null ||
          pickedFolderPath.isEmpty ||
          pickedFolderPath == '/') {
        return;
      }
    }

    scanning.value = true;
    try {
      await scanFilesToBackup();
    } catch (e) {
      printERROR('Error scanning files to backup: $e');
    } finally {
      scanning.value = false;
    }

    backupRunning.value = true;
    try {
      final fileName =
          'estrellamusic_backup_${DateTime.now().millisecondsSinceEpoch}.hmb';

      if (GetPlatform.isAndroid) {
        // En Android moderno (Scoped Storage), escribir directamente en una ruta arbitraria obtenida por FilePicker
        // suele arrojar Errno = 1 (Operation not permitted). Creamos el archivo temporalmente y permitimos guardarlo/compartirlo.
        final tempFile =
            await Get.find<AppBackupService>().createTemporaryBackupArchive();
        await Share.shareXFiles(
          [
            XFile(tempFile.path,
                name: fileName, mimeType: 'application/octet-stream')
          ],
          subject: 'Estrella Music Backup',
        );
        isbackupCompleted.value = true;
      } else {
        final exportDirPath = pickedFolderPath.toString();
        final outputPath = '$exportDirPath/$fileName';
        await Get.find<AppBackupService>().createBackupArchive(
          outputPath: outputPath,
        );
        isbackupCompleted.value = true;
      }
    } catch (e) {
      printERROR('Error during backup: $e');
      errorMessage.value = e.toString();
    } finally {
      backupRunning.value = false;
    }
  }
}

// Function to convert file paths to base64-encoded file data
List<String> filePathsToBase64(List<String> filePaths) {
  List<String> base64Data = [];

  for (String path in filePaths) {
    try {
      // Read the file data as bytes
      File file = File(path);
      List<int> fileData = file.readAsBytesSync();
      // Convert bytes to base64
      String base64String = base64Encode(fileData);
      base64Data.add(base64String);
    } catch (e) {
      printERROR('Error reading file $path: $e');
    }
  }

  return base64Data;
}

// Function to convert file paths to file data (List<int>)
List<List<int>> filePathsToFileData(List<String> filePaths) {
  List<List<int>> filesData = [];

  for (String path in filePaths) {
    try {
      // Read the file data as bytes
      File file = File(path);
      List<int> fileData = file.readAsBytesSync();
      filesData.add(fileData);
    } catch (e) {
      printERROR('Error reading file $path: $e');
    }
  }

  return filesData;
}

// Function to compress files (to be used with compute or isolate)
void _compressFiles(Map<String, dynamic> params) {
  final List<List<int>> filesData = params['filesData'];
  final List<String> fileNames = params['fileNames'];
  final String zipFilePath = params['zipFilePath'];

  final archive = Archive();

  for (int i = 0; i < filesData.length; i++) {
    final fileData = filesData[i];
    final fileName = fileNames[i];
    final file = ArchiveFile(fileName, fileData.length, fileData);
    archive.addFile(file);
  }

  final encoder = ZipEncoder();
  final zipFile = File(zipFilePath);
  zipFile.writeAsBytesSync(encoder.encode(archive)!);
}

// Example usage
Future<void> compressFilesInBackground(
    List<String> filePaths, String zipFilePath) async {
  // Convert file paths to file data
  final List<List<int>> filesData = filePathsToFileData(filePaths);
  final List<String> fileNames = filePaths
      .map((path) => path.split(GetPlatform.isWindows ? '\\' : '/').last)
      .toList();

  printINFO(fileNames);
  // Use compute to run the compression in the background
  await compute(_compressFiles, {
    'filesData': filesData,
    'fileNames': fileNames,
    'zipFilePath': zipFilePath,
  });
}

Future<List<String>> processDirectoryInIsolate(String dbDir,
    {String extensionFilter = ".hive"}) async {
  // Use Isolate.run to execute the function in a new isolate
  return await Isolate.run(() async {
    // List files in the directory
    final filesEntityList =
        await Directory(dbDir).list(recursive: false).toList();

    // Filter out .hive files
    final filesPath = filesEntityList
        .whereType<File>() // Ensure we only work with files
        .map((entity) {
          if (entity.path.endsWith(extensionFilter)) return entity.path;
        })
        .whereType<String>()
        .toList();

    return filesPath;
  });
}
