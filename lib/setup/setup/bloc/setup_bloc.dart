import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  String url;
  SetupBloc() : super(SetupInitial());

  @override
  Stream<SetupState> mapEventToState(
    SetupEvent event,
  ) async* {
    if (event is ConnectNodeEvent) {
      yield ConnectingNodeState(event.url);
      try {
        url = event.url;
        if (url.endsWith('/')) url = url.substring(0, url.length - 1);

        var response = await Dio().get('$url/setup/status');
        if (response.statusCode == 200) {
          yield ConnectingNodeSuccess(url, response.data);
        } else {
          yield ConnectingNodeError(
            event.url,
            response.statusCode,
            response.statusMessage,
          );
          url = '';
        }
      } on DioError catch (e) {
        url = '';
        yield ConnectingNodeError(event.url, 0, e.message);
      }
    }
  }
}
