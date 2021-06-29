part of 'setup_bloc.dart';

@immutable
abstract class SetupEvent {}

class ConnectNodeEvent extends SetupEvent {
  final String url;

  ConnectNodeEvent(this.url);
}
