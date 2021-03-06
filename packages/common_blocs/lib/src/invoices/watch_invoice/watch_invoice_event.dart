part of 'watch_invoice_bloc.dart';

abstract class WatchInvoiceBaseEvent extends Equatable {
  const WatchInvoiceBaseEvent();

  @override
  List<Object> get props => [];
}

class WatchInvoice extends WatchInvoiceBaseEvent {
  final String payReq;

  const WatchInvoice(this.payReq);

  @override
  List<Object> get props => [payReq];
}

class StopWatchInvoice extends WatchInvoiceBaseEvent {
  final String payReq;

  const StopWatchInvoice(this.payReq);

  @override
  List<Object> get props => [payReq];
}

class _InvoiceUpdate extends WatchInvoiceBaseEvent {
  final Invoice invoice;

  const _InvoiceUpdate(this.invoice);

  @override
  List<Object> get props => [invoice.state!, invoice.settleIndex!];
}

class CancelAll extends WatchInvoiceBaseEvent {}
