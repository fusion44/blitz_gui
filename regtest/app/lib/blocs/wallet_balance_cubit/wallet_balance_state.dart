part of 'wallet_balance_cubit.dart';

@immutable
sealed class WalletBalanceState {}

class WalletBalanceInitial extends WalletBalanceState {}

class WalletBalanceUpdated extends WalletBalanceState {
  final WalletBalance balance;

  WalletBalanceUpdated(this.balance);
}
