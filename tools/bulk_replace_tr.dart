// ignore_for_file: avoid_print
import 'dart:io';

void main() {
  final libDir = Directory('lib');
  print('Listing files in lib/...');
  final entities = libDir.listSync(recursive: true, followLinks: false).whereType<File>().toList();
  print('Found ${entities.length} files. Filtering for .dart files...');
  final files = entities.where((f) => f.path.endsWith('.dart')).toList();
  print('Found ${files.length} .dart files. Starting replacement...');

  int modifiedCount = 0;

  // Simple regex with one capturing group
  final trRegExp = RegExp(r"['""]([^'""\n\r]+)['""]s*.tr");

  for (var file in files) {
    final filePath = file.path.replaceAll('\\', '/');
    if (filePath.contains('generated/') || 
        filePath.contains('tools/') || 
        filePath.contains('migrate_to_intl.dart') ||
        filePath.contains('bulk_replace_tr.dart')) {
      continue;
    }

    String content = file.readAsStringSync();
    if (!content.contains('.tr') && !content.contains('l10n_helper.dart')) continue;

    final matches = trRegExp.allMatches(content).toList();
    
    String newContent = content;
    bool modified = false;

    if (matches.isNotEmpty) {
      print('Found ${matches.length} matches in ${file.path}');
      
      // Collect unique keys defensively
      final List<String> uniqueKeys = [];
      for (var m in matches) {
        if (m.groupCount >= 1) {
          final key = m.group(1);
          if (key != null && !uniqueKeys.contains(key)) {
            uniqueKeys.add(key);
          }
        }
      }
      
      // Sort unique keys by length descending to avoid partial replacements
      uniqueKeys.sort((a, b) => b.length.compareTo(a.length));

      for (final originalKey in uniqueKeys) {
        String newKeyName = originalKey.replaceAll('&', 'And').replaceAll(' ', '_').replaceAll('-', '_');
        if (RegExp(r'^\d').hasMatch(newKeyName)) {
          newKeyName = 'v$newKeyName';
        }

        // Replace literal string .tr usage
        final pattern1 = '"$originalKey".tr';
        final pattern2 = "'$originalKey'.tr";
        final pattern3 = '"$originalKey" .tr';
        final pattern4 = "'$originalKey' .tr";
        
        if (newContent.contains(pattern1) || newContent.contains(pattern2) || 
            newContent.contains(pattern3) || newContent.contains(pattern4)) {
          newContent = newContent.replaceAll(pattern1, 'S.current.$newKeyName');
          newContent = newContent.replaceAll(pattern2, 'S.current.$newKeyName');
          newContent = newContent.replaceAll(pattern3, 'S.current.$newKeyName');
          newContent = newContent.replaceAll(pattern4, 'S.current.$newKeyName');
          modified = true;
        }
      }
    }

    // Check if l10n_helper is imported and should be removed
    if (newContent.contains('l10n_helper.dart')) {
      final lines = newContent.split('\n');
      final originalLength = lines.length;
      lines.removeWhere((line) => line.contains('l10n_helper.dart'));
      if (lines.length != originalLength) {
        newContent = lines.join('\n');
        modified = true;
      }
    }

    if (modified) {
      // Add S class import at the top after other imports
      if (!newContent.contains("import 'package:estrella_music/generated/l10n.dart';") &&
          !newContent.contains("import 'generated/l10n.dart';") &&
          !newContent.contains("import '../generated/l10n.dart';") &&
          !newContent.contains("import '../../generated/l10n.dart';")) {
        final lines = newContent.split('\n');
        int insertIndex = 0;
        for (int i = 0; i < lines.length; i++) {
          if (lines[i].startsWith('import ') || lines[i].startsWith('library ')) {
            insertIndex = i + 1;
          } else if (insertIndex > 0 && lines[i].trim().isEmpty) {
             // Keep it at insertIndex
          } else if (insertIndex > 0) {
            break; 
          }
        }
        lines.insert(insertIndex, "import 'package:estrella_music/generated/l10n.dart';");
        newContent = lines.join('\n');
      }
      
      file.writeAsStringSync(newContent);
      modifiedCount++;
      print('Modified ${file.path}');
    }
  }

  print('Bulk replacement complete! Modified $modifiedCount files.');
}
