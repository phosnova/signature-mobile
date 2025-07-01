import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_event.dart';
part 'sign_state.dart';
part 'sign_bloc.freezed.dart';

@injectable
class SignBloc extends Bloc<SignEvent, SignState> {
  SignBloc() : super(SignState.initial()) {
    on<SignEvent>((event, emit) async {
      await event.when(
        started: () => _handleStarted(emit),
        clear: () => _handleClear(emit),
        save: () => _handleSave(emit),
        setImage: (imageBytes) => _handleSetImage(emit, imageBytes),
      );
    });
  }

  Future<void> _handleStarted(Emitter<SignState> emit) async {}

  Future<void> _handleClear(Emitter<SignState> emit) async {
    emit(state.copyWith(signatureImage: null, isSaved: false));
  }

  Future<void> _handleSave(Emitter<SignState> emit) async {
    emit(state.copyWith(isSaved: true));
  }

  Future<void> _handleSetImage(Emitter<SignState> emit, Uint8List imageBytes) async {
    emit(state.copyWith(signatureImage: imageBytes, isSaved: false));
  }
}
