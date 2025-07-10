import 'package:injectable/injectable.dart';

import '../entities/local_file.dart';
import '../repositories/pdf_repository.dart';

@lazySingleton
class GetPdf {
  final PdfRepository pdfRepository;
  GetPdf(this.pdfRepository);

  Future<List<LocalFile>?> call() async => await pdfRepository.getSavedPdf();
}
