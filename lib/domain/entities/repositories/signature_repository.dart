import 'dart:io';
import 'dart:typed_data';

abstract class SignRepository {
  Future<void> saveSignature(Uint8List imageBytes);
  Future<List<File>> getSavedSignatures();
  Future<bool> deleteSignature(String fileName);
}
