part of 'list_tx_bloc.dart';

@immutable
abstract class ListTxEvent {}

class LoadMoreTx extends ListTxEvent {
  final int maxTx;

  /// Loads more transactions up to [maxTx].
  ///
  /// If [maxTx] is set to 0, the bloc attempt to load all
  /// available transactions at once.
  LoadMoreTx([this.maxTx = 25]);
}

class _NewBlocAppended extends ListTxEvent {}
