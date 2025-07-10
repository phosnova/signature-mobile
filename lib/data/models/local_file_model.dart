import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/local_file.dart';

part 'local_file_model.freezed.dart';

@freezed
abstract class LocalFileModel with _$LocalFileModel {
  const factory LocalFileModel({File? file, String? fileName, String? filePath}) = _LocalFileModel;

  const LocalFileModel._();

  LocalFile toDomain() {
    return LocalFile(file: file, fileName: fileName, filePath: filePath);
  }
}
