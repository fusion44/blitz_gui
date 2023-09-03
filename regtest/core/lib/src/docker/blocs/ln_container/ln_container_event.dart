part of 'ln_container_bloc.dart';

@immutable
abstract class LnContainerEvent {}

class StartLnContainerEvent extends LnContainerEvent {}

class LnSettingsUpdatedEvent extends LnContainerEvent {
  final LnNodeOptions options;

  LnSettingsUpdatedEvent(this.options);
}

class StopLnContainerEvent extends LnContainerEvent {}

class DeleteLnContainerEvent extends LnContainerEvent {}

class _LnStatusUpdate extends LnContainerEvent {
  final ContainerStatusMessage status;

  _LnStatusUpdate(this.status);
}
