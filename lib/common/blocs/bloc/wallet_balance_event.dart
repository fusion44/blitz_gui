part of 'wallet_balance_bloc.dart';

abstract class WalletBalanceBaseEvent extends Equatable {
  const WalletBalanceBaseEvent();

  @override
  List<Object> get props => [];
}

class StartListenWalletBalance extends WalletBalanceBaseEvent {}

class StopListenWalletBalance extends WalletBalanceBaseEvent {}

class _WalletBalanceUpdate extends WalletBalanceBaseEvent {
  final WalletBalance balance;

  _WalletBalanceUpdate(this.balance);
}
