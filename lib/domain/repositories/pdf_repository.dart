import 'package:flutter/foundation.dart';

import '../entities/local_file.dart';

abstract class PdfRepository {
  Future<LocalFile> savePdf(Uint8List bytes);
  Future<List<LocalFile>?> getSavedPdf();
  Future<bool> deletePdf(String fileName);
  Future<bool> deleteMultiplePdfFiles(List<String> fileNames);
}
