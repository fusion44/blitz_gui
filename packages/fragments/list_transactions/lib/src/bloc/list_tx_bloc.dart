import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_repository/subscription_repository.dart';

import '../models/transaction.dart';

part 'list_tx_event.dart';
part 'list_tx_state.dart';

class ListTxBloc extends Bloc<ListTxEvent, ListTxState> {
  final AuthRepo _authRepo;
  late final NewBlockWatcherCubit _blockWatcherCubit;
  late final StreamSubscription<NewBlockWatcherState> _blockWatcherSub;
  late final StreamSubscription<Map<String, dynamic>>? _lnSub;

  bool _isLoading = false;

  ListTxBloc(this._authRepo) : super(const ListTxState()) {
    on<LoadMoreTx>(_onLoadMoreTx);
    on<_NewBlocAppended>((event, emit) async {
      final txs = <Transaction>[];
      for (final tx in state.txs) {
        if (tx.category == TxCategory.onchain) {
          txs.add(tx.withIncreasedBlockHeight());
          continue;
        }
        txs.add(tx);
      }
      emit(state.copyWith(txs: txs));
    });

    final subRepo = SubscriptionRepository.instanceChecked();

    _blockWatcherCubit = NewBlockWatcherCubit(subRepo);
    _blockWatcherSub = _blockWatcherCubit.stream.listen((event) {
      if (event is NewBlockAppended) {
        add(_NewBlocAppended());
      }
    });

    _lnSub = subRepo.filteredStream([
      SseEventTypes.lnPaymentStatus,
      SseEventTypes.lnInvoiceStatus,
    ])?.listen(
      (event) {
        // TODO: implement me. Update the status of the payment / invoice
      },
    );
  }

  Future<void> dispose() async {
    await _blockWatcherSub.cancel();
    await _blockWatcherCubit.dispose();
    await _lnSub?.cancel();
  }

  Future<void> _onLoadMoreTx(event, emit) async {
    if (state.hasReachedMax || _isLoading) return;
    try {
      if (state.status == ListTxStatus.initial) {
        final txs = await _fetchTransactions(event);
        return emit(
          state.copyWith(
            status: ListTxStatus.success,
            txs: txs,
            hasReachedMax: event.maxTx > txs.length ? true : false,
          ),
        );
      }
      final transactions = await _fetchTransactions(event);
      emit(
        transactions.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: ListTxStatus.success,
                txs: List.of(state.txs)..addAll(transactions),
                hasReachedMax: false,
              ),
      );
    } catch (_) {
      emit(state.copyWith(status: ListTxStatus.failure));
    }
  }

  Future<List<Transaction>> _fetchTransactions(LoadMoreTx event) async {
    _isLoading = true;
    var i = state.txs.isEmpty ? 0 : state.txs.last.index + 1;
    try {
      final url =
          '${_authRepo.baseUrl()}/latest/lightning/list-all-tx?index_offset=$i&max_tx=${event.maxTx}&reversed=true';
      final response = await fetch(Uri.parse(url), _authRepo.token());
      final js = jsonDecode(response.body);
      final txs = <Transaction>[for (final tx in js) Transaction.fromJson(tx)];
      return txs;
    } catch (e) {
      BlitzLog().e(e.toString());
    } finally {
      _isLoading = false;
    }

    return [];
  }
}
