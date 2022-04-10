import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'models/models.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class NewNodeSetupBloc extends Bloc<SetupEvent, SetupState> {
  final _client = http.Client();
  StreamSubscription<http.StreamedResponse>? _sub;

  String url = '';

  NewNodeSetupBloc() : super(SetupInitial()) {
    on<ConnectNodeEvent>((event, emit) async {
      emit(ConnectingNodeState(event.url));

      try {
        url = event.url;
        if (url.endsWith('/')) url = url.substring(0, url.length - 1);

        var statusResp = await Dio().get('$url/latest/setup/status');
        var setupDataResp =
            await Dio().get('$url/latest/setup/setup-start-info');

        if (statusResp.statusCode != 200) {
          emit(ConnectingNodeError(
            url,
            setupDataResp.statusCode ?? 0,
            setupDataResp.statusMessage ?? '',
          ));
          return;
        }

        if (setupDataResp.statusCode != 200) {
          emit(ConnectingNodeError(
            url,
            setupDataResp.statusCode ?? 0,
            setupDataResp.statusMessage ?? '',
          ));
          return;
        }

        if (statusResp.statusCode == 200) {
          emit(ConnectingNodeSuccess(
            url,
            SetupStatus.fromJson(statusResp.data),
            InitialSetupInfo.fromJson(setupDataResp.data),
          ));
          _connectStream();
        } else {
          emit(ConnectingNodeError(
            event.url,
            statusResp.statusCode ?? 0,
            statusResp.statusMessage ?? '',
          ));
          url = '';
        }
      } on DioError catch (e) {
        url = '';
        emit(ConnectingNodeError(event.url, 0, e.message));
      }
    });
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
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
      event.stream.transform(const Utf8Decoder()).listen((event) {
        if (kDebugMode) {
          print(event);
        }
      });
    });
  }
}
