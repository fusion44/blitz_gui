import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class NewNodeSetupBloc extends Bloc<SetupEvent, SetupState> {
  final _client = http.Client();
  StreamSubscription<http.StreamedResponse> _sub;

  String url;

  NewNodeSetupBloc() : super(SetupInitial());

  Future<void> dispose() async {
    if (_sub != null) {
      await _sub.cancel();
      _sub = null;
    }
  }

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
          _connectStream();
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

  void _connectStream() async {
    if (_sub != null) {
      return;
    }

    final request = http.Request('get', Uri.parse(url + '/sse/subscribe'));
    request.headers['Cache-Control'] = 'no-cache';
    request.headers['Accept'] = 'text/event-stream';
    // request.headers['Cookie'] = 'token';
    final response = _client.send(request);
    _sub = response.asStream().listen((event) {
      event.stream.transform(Utf8Decoder()).listen((event) {
        print(event);
      });
    });
  }
}
