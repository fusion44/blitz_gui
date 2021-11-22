import 'dart:async';

import '../../invoices/models/invoices.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:subscription_repository/subscription_repository.dart';

part 'watch_invoice_event.dart';
part 'watch_invoice_state.dart';

class WatchInvoiceBloc
    extends Bloc<WatchInvoiceBaseEvent, WatchInvoiceBaseState> {
  final SubscriptionRepository _subRepo;
  final _events = <String>[];

  StreamSubscription<Map<String, dynamic>>? _sub;
  WatchInvoiceBloc(this._subRepo) : super(WatchInvoiceInitial()) {
    on<WatchInvoiceBaseEvent>(_onEvent, transformer: sequential());

    _listenSystemEvents();
  }

  FutureOr<void> _onEvent(
    WatchInvoiceBaseEvent event,
    Emitter<WatchInvoiceBaseState> emit,
  ) async {
    if (event is WatchInvoice) {
      _events.add(event.payReq);
    } else if (event is StopWatchInvoice) {
      _events.remove(event.payReq);
    } else if (event is CancelAll) {
      _events.clear();
      await _sub?.cancel();
    } else if (event is _InvoiceUpdate) {
      emit(InvoiceUpdateState(event.invoice));
    }
  }

  void _listenSystemEvents() {
    _sub = _subRepo.filteredStream(
      [SseEventTypes.lnInvoiceStatus],
    )?.listen((event) {
      final i = Invoice.fromJson(event['data']);
      if (_events.contains(i.paymentRequest)) {
        add(_InvoiceUpdate(i));
      }
    });
  }
}
