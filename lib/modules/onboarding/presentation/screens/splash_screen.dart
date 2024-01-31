import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_terms/modules/onboarding/presentation/bloc/launch_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<LaunchCubit, LaunchState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Speech to Terms",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                if (state is DownloadStarted) ...[
                  const Text(
                    "Downloading resources...",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  const CircularProgressIndicator()
                ],
                if (state is InitializeAppStatus && !state.status)
                  const Text(
                    "Something went wrong, Please try again",
                    textAlign: TextAlign.center,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
