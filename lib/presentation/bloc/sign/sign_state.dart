part of 'sign_bloc.dart';

@freezed
class SignState with _$SignState {
  const factory SignState({
    required Uint8List? signatureImage,
    required bool isSaved,
    required bool isInitial,
    required bool isFailure,
    List<File>? savedSignatures,
    String? message,
  }) = _SignState;

  factory SignState.initial() => SignState(
    signatureImage: null,
    isInitial: false,
    isSaved: false,
    isFailure: false,
    savedSignatures: [],
    message: null,
  );
}
