part of 'list_tx_bloc.dart';

enum ListTxStatus { initial, success, failure }

class ListTxState extends Equatable {
  const ListTxState({
    this.status = ListTxStatus.initial,
    this.txs = const <Transaction>[],
    this.hasReachedMax = false,
  });

  final ListTxStatus status;
  final List<Transaction> txs;
  final bool hasReachedMax;

  ListTxState copyWith({
    ListTxStatus? status,
    List<Transaction>? txs,
    bool? hasReachedMax,
  }) {
    return ListTxState(
      status: status ?? this.status,
      txs: txs ?? this.txs,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ListTxState { status: $status, hasReachedMax: $hasReachedMax, posts: ${txs.length} }''';
  }

  @override
  List<Object> get props => [status, txs, hasReachedMax];
}
