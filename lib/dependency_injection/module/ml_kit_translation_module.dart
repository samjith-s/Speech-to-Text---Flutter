import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:injectable/injectable.dart';

@module
abstract class MLKitTranslationModule {
  @lazySingleton
  OnDeviceTranslatorModelManager get translatorModelManager => OnDeviceTranslatorModelManager();
}
