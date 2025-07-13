import 'package:injectable/injectable.dart';

import '../repositories/pdf_repository.dart';

@lazySingleton
class DeleteMultiplePdf {
  final PdfRepository pdfRepository;
  DeleteMultiplePdf(this.pdfRepository);

  Future<bool> call(List<String> fileNames) => pdfRepository.deleteMultiplePdfFiles(fileNames);
}
