import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:injectable/injectable.dart';

part 'launch_state.dart';

@injectable
class LaunchCubit extends Cubit<LaunchState> {
  final OnDeviceTranslatorModelManager _onDeviceTranslatorModelManager;

  LaunchCubit(this._onDeviceTranslatorModelManager) : super(LaunchInitial());

  Future<void> initializeApp() async {
    emit(DownloadStarted());
    final bool available = await _onDeviceTranslatorModelManager.isModelDownloaded(TranslateLanguage.hindi.bcpCode);
    if (available) {
      emit(InitializeAppStatus(true));
    } else {
      final bool response = await _onDeviceTranslatorModelManager.downloadModel(TranslateLanguage.hindi.bcpCode);
      if (response) {
        emit(InitializeAppStatus(true));
      } else {
        emit(InitializeAppStatus(false));
      }
    }
  }
}
