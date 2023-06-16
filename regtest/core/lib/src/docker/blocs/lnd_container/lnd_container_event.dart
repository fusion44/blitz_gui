part of 'lnd_container_bloc.dart';

@immutable
abstract class LndContainerEvent {}

class StartLndContainerEvent extends LndContainerEvent {}

class LndSettingsUpdatedEvent extends LndContainerEvent {
  final LndOptions options;

  LndSettingsUpdatedEvent(this.options);
}

class StopLndContainerEvent extends LndContainerEvent {}

class DeleteLndContainerEvent extends LndContainerEvent {}

class _LndStatusUpdate extends LndContainerEvent {
  final ContainerStatusMessage status;

  _LndStatusUpdate(this.status);
}
