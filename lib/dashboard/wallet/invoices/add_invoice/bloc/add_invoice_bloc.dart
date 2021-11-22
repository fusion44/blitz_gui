import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:common/common.dart';
import 'package:equatable/equatable.dart';

part 'add_invoice_event.dart';
part 'add_invoice_state.dart';

class AddInvoiceBloc extends Bloc<AddInvoiceBaseEvent, AddInvoiceBaseState> {
  final AuthRepo _authRepo;
  AddInvoiceBloc(this._authRepo) : super(AddInvoiceInitial()) {
    on<AddInvoiceBaseEvent>(_onEvent, transformer: sequential());
  }

  FutureOr<void> _onEvent(
    AddInvoiceBaseEvent event,
    Emitter<AddInvoiceBaseState> emit,
  ) async {
    if (event is AddInvoiceEvent) {
      final response = await post(
        Uri.parse('${_authRepo.baseUrl()}/latest/lightning/add-invoice'),
        _authRepo.token(),
        {
          'value_msat': event.amount * 1000,
          'memo': event.memo,
        },
      );

      if (response.statusCode == 200) {
        // emit(InvoiceAddedState(response.body['payment_request']));
      } else {
        emit(AddInvoiceErrorState(response.reasonPhrase));
      }
    }
  }
}
