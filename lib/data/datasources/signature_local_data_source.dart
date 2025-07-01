import 'dart:io';
import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SignatureLocalDataSource {
  Future<bool> saveSignature(Uint8List imageBytes);
  Future<List<File>> getSavedSignatures();
  Future<bool> deleteSignature(String fileName);
}

@LazySingleton(as: SignatureLocalDataSource)
class SignatureLocalDataSourceImpl implements SignatureLocalDataSource {
  static const _key = 'signature_files';

  Future<String> _getDirectoryPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  @override
  Future<bool> saveSignature(Uint8List imageBytes) async {
    try {
      final path = await _getDirectoryPath();
      final file = File('$path/${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(imageBytes);
      final prefs = await SharedPreferences.getInstance();
      final files = prefs.getStringList(_key) ?? [];

      files.add(file.path);

      await prefs.setStringList(_key, files);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<File>> getSavedSignatures() async {
    final path = await _getDirectoryPath();
    final prefs = await SharedPreferences.getInstance();
    final fileNames = prefs.getStringList(_key) ?? [];

    return fileNames.map((name) => File('$path/$name')).toList();
  }

  @override
  Future<bool> deleteSignature(String fileName) async {
    try {
      final path = await _getDirectoryPath();
      final file = File('$path/$fileName');

      if (await file.exists()) {
        await file.delete();
      }

      final prefs = await SharedPreferences.getInstance();
      final files = prefs.getStringList(_key) ?? [];

      files.remove(fileName);

      await prefs.setStringList(_key, files);

      return true;
    } catch (e) {
      return false;
    }
  }
}
