import 'dart:io';

import 'package:path_provider/path_provider.dart';

class NotepadService {
  // Get the file path
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/notepad.txt');
  }

  // Save data to file (overwrite existing content)
  Future<void> saveToFile(String content) async {
    final file = await _getFile();
    await file.writeAsString(content);
  }

  // Append data to file
  Future<void> appendToFile(String content) async {
    final file = await _getFile();
    await file.writeAsString(content, mode: FileMode.append);
  }

  // Read data from file
  Future<String> readFromFile() async {
    try {
      final file = await _getFile();
      return await file.readAsString();
    } catch (e) {
      return 'No content found. Start by saving something!';
    }
  }
}