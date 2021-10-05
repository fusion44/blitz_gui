part of 'add_invoice_bloc.dart';

abstract class AddInvoiceBaseState extends Equatable {
  const AddInvoiceBaseState();

  @override
  List<Object> get props => [];
}

class AddInvoiceInitial extends AddInvoiceBaseState {}

class InvoiceAddedState extends AddInvoiceBaseState {
  final String payReq;

  const InvoiceAddedState(this.payReq);

  @override
  List<Object> get props => [payReq];
}

class AddInvoiceErrorState extends AddInvoiceBaseState {
  final String? errorMessage;

  const AddInvoiceErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage!];
}
