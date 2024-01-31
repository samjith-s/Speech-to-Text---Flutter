import 'package:speech_to_terms/dependency_injection/injection_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
)
Future<void> configureDependencies() async => getIt.init(
      environment: Environment.prod,
    );
