import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'add_invoice_event.dart';
part 'add_invoice_state.dart';

class AddInvoiceBloc extends Bloc<AddInvoiceBaseEvent, AddInvoiceBaseState> {
  AddInvoiceBloc() : super(AddInvoiceInitial());

  @override
  Stream<AddInvoiceBaseState> mapEventToState(
    AddInvoiceBaseEvent event,
  ) async* {
    if (event is AddInvoiceEvent) {
      var response = await Dio()
          .post('http://127.0.0.1:8000/lightning/addinvoice', queryParameters: {
        'value_msat': event.amount * 1000,
        'memo': event.memo,
      });
      if (response.statusCode == 200) {
        yield InvoiceAddedState(response.data['payment_request']);
      } else {
        yield AddInvoiceErrorState(response.statusMessage);
      }
    }
  }
}
