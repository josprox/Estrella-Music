// ignore_for_file: avoid_print
import 'dart:io';

void main() {
  final libDir = Directory('lib');
  final files = libDir.listSync(recursive: true, followLinks: false).whereType<File>().where((f) => f.path.endsWith('.dart')).toList();

  int modifiedCount = 0;

  for (var file in files) {
    if (file.path.contains('generated/') || file.path.contains('tools/')) continue;

    String content = file.readAsStringSync();
    
    // Check if it still has .tr (likely dynamic one)
    if (!content.contains('.tr')) continue;

    // Check if it's NOT a literal replacement already handled
    // Actually, if it has .tr, it needs the helper extension to work.
    
    if (!content.contains("import 'package:estrella_music/utils/l10n_helper.dart';") &&
        !content.contains("import '/utils/l10n_helper.dart';")) {
      
      final lines = content.split('\n');
      int insertIndex = 0;
      for (int i = 0; i < lines.length; i++) {
        if (lines[i].startsWith('import ')) {
          insertIndex = i + 1;
        }
      }
      lines.insert(insertIndex, "import 'package:estrella_music/utils/l10n_helper.dart';");
      file.writeAsStringSync(lines.join('\n'));
      modifiedCount++;
      print('Added helper import to ${file.path}');
    }
  }

  print('L10n helper import injection complete! Modified $modifiedCount files.');
}
