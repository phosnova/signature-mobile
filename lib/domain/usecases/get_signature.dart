import 'dart:io';

import 'package:injectable/injectable.dart';

import '../repositories/signature_repository.dart';

@lazySingleton
class GetSignature {
  final SignatureRepository signatureRepository;
  GetSignature(this.signatureRepository);

  Future<List<File>> call() => signatureRepository.getSavedSignatures();
}
