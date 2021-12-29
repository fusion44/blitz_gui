part of 'wallet_locked_checker_bloc.dart';

@immutable
abstract class WalletLockedCheckerEvent {}

class StartCheckWalletLocked extends WalletLockedCheckerEvent {}

class StopCheckWalletLocked extends WalletLockedCheckerEvent {}

class WalletLockStateUpdate extends WalletLockedCheckerEvent {
  final bool isLocked;

  WalletLockStateUpdate(this.isLocked);
}
