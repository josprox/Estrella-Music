// ignore_for_file: avoid_print
import 'dart:io';

void main() {
  final file = File('lib/ui/widgets/song_list_tile.dart');
  if (!file.existsSync()) {
    print('File not found!');
    return;
  }
  final content = file.readAsStringSync();
  print('Content length: ${content.length}');
  print('Contains .tr: ${content.contains('.tr')}');
  
  final regExp = RegExp(r"['""]([^'""\n\r]+)['""]s*.tr");
  final matches = regExp.allMatches(content);
  print('Matches found: ${matches.length}');
  for (var m in matches) {
    print('Match: ${m.group(0)} | Key: ${m.group(2)}');
  }
  
  if (matches.isEmpty) {
    print('No matches found for literal strings. Trying to find any .tr...');
    final trIndex = content.indexOf('.tr');
    if (trIndex != -1) {
      final context = content.substring(trIndex - 20, trIndex + 5);
      print('Context of first .tr: "$context"');
    }
  }
}
