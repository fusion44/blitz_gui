part of 'add_invoice_bloc.dart';

abstract class AddInvoiceBaseEvent extends Equatable {
  const AddInvoiceBaseEvent();

  @override
  List<Object> get props => [];
}

class AddInvoiceEvent extends AddInvoiceBaseEvent {
  final int amount;
  final String memo;

  const AddInvoiceEvent(this.amount, this.memo);

  @override
  List<Object> get props => [amount, memo];
}
