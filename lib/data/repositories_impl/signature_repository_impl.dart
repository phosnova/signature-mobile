import 'dart:typed_data';

import 'package:injectable/injectable.dart';

import '../../domain/entities/signature.dart';
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
  Future<List<Sign>?> getSavedSignatures() async {
    try {
      final result = await signatureLocalDataSource.getSavedSignatures();

      if (result == null) return [];

      return result.map((e) => e.toDomain()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Sign> saveSignature(Uint8List imageBytes) async {
    try {
      final result = await signatureLocalDataSource.saveSignature(imageBytes);

      if (result == null) throw Exception('Gagal Menyimpan Tanda Tangan');

      return result.toDomain();
    } catch (e) {
      rethrow;
    }
  }
}
