// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_mlkit_translation/google_mlkit_translation.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:speech_to_terms/core/repository/remote_repository.dart' as _i5;
import 'package:speech_to_terms/dependency_injection/module/firebase_module.dart'
    as _i11;
import 'package:speech_to_terms/dependency_injection/module/ml_kit_translation_module.dart'
    as _i12;
import 'package:speech_to_terms/modules/onboarding/presentation/bloc/launch_cubit.dart'
    as _i9;
import 'package:speech_to_terms/modules/terms_listing/data/network/terms_n_conditions_api.dart'
    as _i6;
import 'package:speech_to_terms/modules/terms_listing/data/repository/terms_n_condtions_repo_imp.dart'
    as _i8;
import 'package:speech_to_terms/modules/terms_listing/domain/repository/i_terms_n_contions_repo.dart'
    as _i7;
import 'package:speech_to_terms/modules/terms_listing/presentation/bloc/terms_and_conditions_bloc.dart'
    as _i10;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModule = _$FirebaseModule();
    final mLKitTranslationModule = _$MLKitTranslationModule();
    gh.lazySingleton<_i3.FirebaseFirestore>(
        () => firebaseModule.firestoreInstance);
    gh.lazySingleton<_i4.OnDeviceTranslatorModelManager>(
        () => mLKitTranslationModule.translatorModelManager);
    gh.factory<_i5.RemoteRepository>(() => _i5.RemoteRepository());
    gh.factory<_i6.TermsAndConditionsAPI>(() => _i6.TermsAndConditionsAPI(
          gh<_i3.FirebaseFirestore>(),
          gh<_i5.RemoteRepository>(),
        ));
    gh.factory<_i7.ITermsNConditionsRepository>(
        () => _i8.TermsNConditionsRepository(gh<_i6.TermsAndConditionsAPI>()));
    gh.factory<_i9.LaunchCubit>(
        () => _i9.LaunchCubit(gh<_i4.OnDeviceTranslatorModelManager>()));
    gh.factory<_i10.TermsAndConditionsBloc>(() =>
        _i10.TermsAndConditionsBloc(gh<_i7.ITermsNConditionsRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i11.FirebaseModule {}

class _$MLKitTranslationModule extends _i12.MLKitTranslationModule {}
