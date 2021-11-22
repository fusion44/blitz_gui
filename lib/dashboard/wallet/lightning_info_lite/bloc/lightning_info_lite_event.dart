part of 'lightning_info_lite_bloc.dart';

abstract class LightningInfoLiteEvent extends Equatable {
  const LightningInfoLiteEvent();

  @override
  List<Object> get props => [];
}

class StartListenLightningInfoLite extends LightningInfoLiteEvent {}

class StopListenLightningInfoLite extends LightningInfoLiteEvent {}

class _LightningInfoLiteUpdate extends LightningInfoLiteEvent {
  final LightningInfoLite? lnInfo;

  const _LightningInfoLiteUpdate({this.lnInfo});
}
