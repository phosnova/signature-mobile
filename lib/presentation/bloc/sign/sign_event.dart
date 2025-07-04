part of 'sign_bloc.dart';

@freezed
class SignEvent with _$SignEvent {
  const factory SignEvent.started() = _Started;
  const factory SignEvent.clear() = _Clear;
  const factory SignEvent.save(Uint8List imageBytes) = _SetImage;
  const factory SignEvent.delete(String fileName) = _DeleteImage;
}
