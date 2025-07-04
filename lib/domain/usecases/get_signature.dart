import 'package:injectable/injectable.dart';

import '../entities/signature.dart';
import '../repositories/signature_repository.dart';

@lazySingleton
class GetSignature {
  final SignatureRepository signatureRepository;
  GetSignature(this.signatureRepository);

  Future<List<Sign?>> call() async => await signatureRepository.getSavedSignatures().then((result) => result);
}
