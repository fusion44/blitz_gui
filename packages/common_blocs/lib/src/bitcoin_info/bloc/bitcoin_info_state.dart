part of 'bitcoin_info_bloc.dart';

abstract class BitcoinInfoBaseState extends Equatable {
  const BitcoinInfoBaseState();

  @override
  List<Object> get props => [];
}

class BitcoinInfoInitial extends BitcoinInfoBaseState {}

class BitcoinInfoState extends BitcoinInfoBaseState {
  final BitcoinInfo info;

  const BitcoinInfoState(this.info);

  @override
  List<Object> get props => [info];
}
