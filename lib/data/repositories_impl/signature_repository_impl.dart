import 'dart:io';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';

import '../../domain/repositories/signature_repository.dart';
import '../datasources/signature_local_data_source.dart';

@LazySingleton(as: SignatureRepository)
class SignatureRepositoryImpl implements SignatureRepository {
  final SignatureLocalDataSource signatureLocalDataSource;

  SignatureRepositoryImpl({required this.signatureLocalDataSource});

  @override
  Future<bool> deleteSignature(String fileName) {
    return signatureLocalDataSource.deleteSignature(fileName);
  }

  @override
  Future<List<File>> getSavedSignatures() {
    return signatureLocalDataSource.getSavedSignatures();
  }

  @override
  Future<bool> saveSignature(Uint8List imageBytes) {
    return signatureLocalDataSource.saveSignature(imageBytes);
  }
}
