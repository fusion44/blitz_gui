import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'add_invoice_event.dart';
part 'add_invoice_state.dart';

class AddInvoiceBloc extends Bloc<AddInvoiceBaseEvent, AddInvoiceBaseState> {
  AddInvoiceBloc() : super(AddInvoiceInitial()) {
    on<AddInvoiceBaseEvent>(_onEvent, transformer: sequential());
  }

  FutureOr<void> _onEvent(
    AddInvoiceBaseEvent event,
    Emitter<AddInvoiceBaseState> emit,
  ) async {
    if (event is AddInvoiceEvent) {
      var response = await Dio()
          .post('http://127.0.0.1:8000/lightning/addinvoice', queryParameters: {
        'value_msat': event.amount * 1000,
        'memo': event.memo,
      });
      if (response.statusCode == 200) {
        emit(InvoiceAddedState(response.data['payment_request']));
      } else {
        emit(AddInvoiceErrorState(response.statusMessage));
      }
    }
  }
}
