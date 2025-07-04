import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/signature.dart';

part 'signature_model.freezed.dart';

@freezed
abstract class SignatureModel with _$SignatureModel {
  const factory SignatureModel({File? image, String? fileName, String? filePath}) = _SignatureModel;

  const SignatureModel._();

  Sign toDomain() {
    return Sign(image: image, fileName: fileName, filePath: filePath);
  }
}
