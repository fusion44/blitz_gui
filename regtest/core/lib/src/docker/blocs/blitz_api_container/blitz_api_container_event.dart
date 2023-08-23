part of 'blitz_api_container_bloc.dart';

@immutable
abstract class BlitzApiContainerEvent {}

class StartBlitzApiContainerEvent extends BlitzApiContainerEvent {}

class BlitzApiSettingsUpdatedEvent extends BlitzApiContainerEvent {
  final BlitzApiOptions options;

  BlitzApiSettingsUpdatedEvent(this.options);
}

class StopBlitzApiContainerEvent extends BlitzApiContainerEvent {}

class DeleteBlitzApiContainerEvent extends BlitzApiContainerEvent {}

class _BlitzApiStatusUpdate extends BlitzApiContainerEvent {
  final ContainerStatusMessage status;

  _BlitzApiStatusUpdate(this.status);
}

class BlitzApiOpenChannelEvent extends BlitzApiContainerEvent {
  final String targetContainerId;
  final int localFundingAmount;
  final int pushAmountSat;

  BlitzApiOpenChannelEvent(
    this.targetContainerId,
    this.localFundingAmount,
    this.pushAmountSat,
  );
}
