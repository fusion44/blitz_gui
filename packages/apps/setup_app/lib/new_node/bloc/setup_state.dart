part of 'setup_bloc.dart';

@immutable
abstract class SetupState {}

class SetupInitial extends SetupState {}

class ConnectingNodeState extends SetupState {
  final String url;

  ConnectingNodeState(this.url);
}

class ConnectingNodeSuccess extends SetupState {
  final String url;
  final SetupStatus status;
  final InitialSetupInfo setupInfo;

  ConnectingNodeSuccess(this.url, this.status, this.setupInfo);
}

class ConnectingNodeError extends SetupState {
  final String url;
  final int status;
  final String errorMessage;

  ConnectingNodeError(this.url, this.status, this.errorMessage);
}
