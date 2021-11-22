part of 'watch_invoice_bloc.dart';

abstract class WatchInvoiceBaseState extends Equatable {
  const WatchInvoiceBaseState();

  @override
  List<Object> get props => [];
}

class WatchInvoiceInitial extends WatchInvoiceBaseState {}

class InvoiceUpdateState extends WatchInvoiceBaseState {
  final Invoice invoice;

  const InvoiceUpdateState(this.invoice);

  @override
  List<Object> get props => [invoice, invoice.state!, invoice.settleDate!];
}
