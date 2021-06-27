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
  final Map<String, dynamic> state;

  ConnectingNodeSuccess(this.url, this.state);
}

class ConnectingNodeError extends SetupState {
  final String url;
  final int status;
  final String errorMessage;

  ConnectingNodeError(this.url, this.status, this.errorMessage);
}
