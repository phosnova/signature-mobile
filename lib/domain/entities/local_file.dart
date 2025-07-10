import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_file.freezed.dart';

@freezed
abstract class LocalFile with _$LocalFile {
  const factory LocalFile({File? file, String? fileName, String? filePath}) = _LocalFile;

  const LocalFile._(); // Private constructor
}
