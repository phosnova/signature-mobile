import 'dart:io';
import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/local_file_model.dart';

abstract class PdfLocalDatasource {
  Future<LocalFileModel?> savePdfFile(Uint8List bytes);
  Future<List<LocalFileModel>?> getPdfBytes();
  Future<bool> deletePdfFile(String fileName);
}

@LazySingleton(as: PdfLocalDatasource)
class PdfLocalDatasourceImpl extends PdfLocalDatasource {
  static const _key = 'saved_pdf_files';

  Future<String> _getDirectoryPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  @override
  Future<LocalFileModel?> savePdfFile(Uint8List bytes) async {
    try {
      final path = await _getDirectoryPath();
      final fileName = 'signed_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('$path/$fileName');
      await file.writeAsBytes(bytes, flush: true);

      final prefs = await SharedPreferences.getInstance();
      final paths = prefs.getStringList(_key) ?? [];

      paths.add(file.path);
      await prefs.setStringList(_key, paths);

      return LocalFileModel(file: file, fileName: fileName, filePath: file.path);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<LocalFileModel>?> getPdfBytes() async {
    final prefs = await SharedPreferences.getInstance();
    final paths = prefs.getStringList(_key) ?? [];

    return paths
        .map((path) => LocalFileModel(file: File(path), fileName: path.split('/').last, filePath: path))
        .toList();
  }

  @override
  Future<bool> deletePdfFile(String fileName) async {
    try {
      final path = await _getDirectoryPath();
      final file = File('$path/$fileName');

      if (await file.exists()) {
        await file.delete();
      }

      final prefs = await SharedPreferences.getInstance();
      final files = prefs.getStringList(_key) ?? [];

      files.removeWhere((element) => element.endsWith(fileName));

      await prefs.setStringList(_key, files);

      return true;
    } catch (e) {
      return false;
    }
  }
}
