import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../common/models/models.dart';
import '../../../../common/subscription_repository.dart';

part 'watch_invoice_event.dart';
part 'watch_invoice_state.dart';

class WatchInvoiceBloc
    extends Bloc<WatchInvoiceBaseEvent, WatchInvoiceBaseState> {
  final SubscriptionRepository _subRepo;
  final _events = <String>[];

  StreamSubscription<Map<String, dynamic>>? _sub;
  WatchInvoiceBloc(this._subRepo) : super(WatchInvoiceInitial()) {
    _listenSystemEvents();
  }

  @override
  Stream<WatchInvoiceBaseState> mapEventToState(
    WatchInvoiceBaseEvent event,
  ) async* {
    if (event is WatchInvoice) {
      _events.add(event.payReq);
    } else if (event is StopWatchInvoice) {
      _events.remove(event.payReq);
    } else if (event is CancelAll) {
      _events.clear();
      await _sub?.cancel();
    } else if (event is _InvoiceUpdate) {
      yield InvoiceUpdateState(event.invoice);
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
