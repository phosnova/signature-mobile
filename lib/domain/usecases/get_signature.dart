import 'package:injectable/injectable.dart';

import '../entities/local_file.dart';
import '../repositories/signature_repository.dart';

@lazySingleton
class GetSignature {
  final SignatureRepository signatureRepository;
  GetSignature(this.signatureRepository);

  Future<List<LocalFile>?> call() async => await signatureRepository.getSavedSignatures();
}
