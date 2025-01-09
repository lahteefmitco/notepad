import 'dart:developer';
import 'dart:io';



class NotepadService {
  // Get the file path
  Future<File> _getFile() async {
    try {
      final Directory directory = Directory('/storage/emulated/0/notepad');
      ;

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      log("Path: - ${directory.path}");

      return File('${directory.path}/notepad.txt');
    } catch (e) {
      rethrow;
    }
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
      if (!await file.exists()) {
        throw Exception("File is not available");
      }
      return await file.readAsString();
    } catch (e) {
      log("Error:- $e");
      return 'No content found. Start by saving something!';
    }
  }
}
