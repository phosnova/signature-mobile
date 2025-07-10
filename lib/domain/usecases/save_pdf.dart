import 'dart:typed_data';

import 'package:injectable/injectable.dart';

import '../entities/local_file.dart';
import '../repositories/pdf_repository.dart';

@lazySingleton
class SavePdf {
  final PdfRepository pdfRepository;
  SavePdf(this.pdfRepository);

  Future<LocalFile?> call(Uint8List imageBytes) {
    return pdfRepository.savePdf(imageBytes).then((result) => result);
  }
}
