part of 'launch_cubit.dart';

@immutable
abstract class LaunchState {}

class LaunchInitial extends LaunchState {}

class InitializeAppStatus extends LaunchState {
  final bool status;

  InitializeAppStatus(this.status);
}

class DownloadStarted extends LaunchState {}
