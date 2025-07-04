import 'dart:io';
import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/signature_model.dart';

abstract class SignatureLocalDataSource {
  Future<SignatureModel?> saveSignature(Uint8List imageBytes);
  Future<List<SignatureModel?>> getSavedSignatures();
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
  Future<SignatureModel?> saveSignature(Uint8List imageBytes) async {
    try {
      final path = await _getDirectoryPath();
      final file = File('$path/${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(imageBytes);

      final prefs = await SharedPreferences.getInstance();
      final paths = prefs.getStringList(_key) ?? [];

      paths.add(file.path);
      await prefs.setStringList(_key, paths);

      return SignatureModel(image: file, fileName: file.path);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<SignatureModel?>> getSavedSignatures() async {
    final prefs = await SharedPreferences.getInstance();
    final fileNames = prefs.getStringList(_key) ?? [];

    final signatures =
        fileNames
            .map((fileName) => SignatureModel(image: File(fileName), fileName: fileName, filePath: fileName))
            .toList();

    return signatures;
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
