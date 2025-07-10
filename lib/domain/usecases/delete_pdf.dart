import 'package:injectable/injectable.dart';

import '../repositories/pdf_repository.dart';

@lazySingleton
class DeletePdf {
  final PdfRepository pdfRepository;
  DeletePdf(this.pdfRepository);

  Future<bool> call(String fileName) => pdfRepository.deletePdf(fileName);
}
