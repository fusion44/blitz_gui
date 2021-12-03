part of 'wallet_locked_checker_bloc.dart';

@immutable
abstract class WalletLockedCheckerState {}

class WalletLockedCheckerInitial extends WalletLockedCheckerState {}

class LoadingWalletStatus extends WalletLockedCheckerState {}

class WalletLocked extends WalletLockedCheckerState {}

class WalletUnlocked extends WalletLockedCheckerState {}
