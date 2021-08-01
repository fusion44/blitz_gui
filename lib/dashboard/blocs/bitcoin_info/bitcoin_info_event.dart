part of 'bitcoin_info_bloc.dart';

abstract class BitcoinInfoEvent extends Equatable {
  const BitcoinInfoEvent();

  @override
  List<Object> get props => [];
}

class StartListenBitcoinInfo extends BitcoinInfoEvent {}

class StopListenBitcoinInfo extends BitcoinInfoEvent {}

class _BitcoinInfoUpdate extends BitcoinInfoEvent {
  final BitcoinInfo info;

  _BitcoinInfoUpdate(this.info);
}
