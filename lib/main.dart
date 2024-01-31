import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_terms/dependency_injection/injection_container.dart';
import 'package:speech_to_terms/modules/terms_listing/presentation/bloc/terms_and_conditions_bloc.dart';
import 'package:speech_to_terms/modules/terms_listing/presentation/screens/terms_listing_screen.dart';

import 'firebase_options.dart';
import 'modules/onboarding/presentation/bloc/launch_cubit.dart';
import 'modules/onboarding/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<TermsAndConditionsBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<LaunchCubit>()..initializeApp(),
        ),
      ],
      child: MaterialApp(
        title: 'Speech to text',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocListener<LaunchCubit, LaunchState>(
          listener: (BuildContext context, state) async {
            if (state is InitializeAppStatus) {
              if (state.status) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const TermsNConditionsListingScreen(),
                  ),
                  (route) => false,
                );
              }
            }
          },
          child: const SplashScreen(),
        ),
      ),
    );
  }
}
