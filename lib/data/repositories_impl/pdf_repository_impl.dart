import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/local_file.dart';
import '../../domain/repositories/pdf_repository.dart';
import '../datasources/pdf_local_data_source.dart';

@LazySingleton(as: PdfRepository)
class PdfRepositoryImpl implements PdfRepository {
  final PdfLocalDatasource _pdfLocalDataSource;

  PdfRepositoryImpl(this._pdfLocalDataSource);

  @override
  Future<LocalFile> savePdf(Uint8List bytes) async {
    try {
      final result = await _pdfLocalDataSource.savePdfFile(bytes);

      if (result == null) throw Exception('Gagal Menyimpan PDF');

      return result.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LocalFile>?> getSavedPdf() async {
    try {
      final result = await _pdfLocalDataSource.getPdfBytes();

      if (result == null) return [];

      return result.map((e) => e.toDomain()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deletePdf(String fileName) {
    return _pdfLocalDataSource.deletePdfFile(fileName);
  }

  @override
  Future<bool> deleteMultiplePdfFiles(List<String> fileNames) {
    return _pdfLocalDataSource.deleteMultiplePdfFiles(fileNames);
  }
}
