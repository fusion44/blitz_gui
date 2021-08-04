part of 'wallet_balance_bloc.dart';

abstract class WalletBalanceBaseState extends Equatable {
  const WalletBalanceBaseState();

  @override
  List<Object> get props => [];
}

class WalletBalanceInitial extends WalletBalanceBaseState {}

class WalletBalanceUpdated extends WalletBalanceBaseState {
  final WalletBalance balance;

  WalletBalanceUpdated(this.balance);

  @override
  List<Object> get props => [balance];
}
