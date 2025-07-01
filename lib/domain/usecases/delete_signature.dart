import 'package:injectable/injectable.dart';

import '../repositories/signature_repository.dart';

@lazySingleton
class DeleteSignature {
  final SignatureRepository signatureRepository;
  DeleteSignature(this.signatureRepository);

  Future<bool> call(String fileName) => signatureRepository.deleteSignature(fileName);
}
