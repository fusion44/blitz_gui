// From: https://pub.dev/packages/flutter_client_sse

library sse_client;

import 'dart:async';

import 'package:common/common.dart';
import 'package:http/http.dart' as http;
import 'sse_model.dart';
import 'html.dart' if (dart.library.io) 'io.dart';

class SSEClient {
  static final http.Client _client = http.Client();
  static Future<Stream<SSEModel>> subscribeToSSE(
    String url,
    String token,
  ) async {
    //Creating a instance of the SSEModel
    var currentSSEModel = SSEModel(data: '', id: '', event: '');
    // ignore: close_sinks
    StreamController<SSEModel> streamController = StreamController();
    while (true) {
      try {
        final stream = await establishSSEConnection(url, token);
        stream.listen((dataLine) {
          if (dataLine.isEmpty) {
            //This means that the complete event set has been read.
            //We then add the event to the stream
            streamController.add(currentSSEModel);
            currentSSEModel = SSEModel(data: '', id: '', event: '');
            return;
          }

          int fistIndex = dataLine.indexOf(':');
          List spl = [
            dataLine.substring(0, fistIndex).trim(),
            dataLine.substring(fistIndex + 1).trim()
          ];
          if (spl.length != 2) {
            BlitzLog().w('Received a malformed SSE message:\n$dataLine');
            return;
          }
          final field = spl.first.replaceAll(':', '').trim();
          final value = spl.last.trim();
          switch (field) {
            case 'event':
              currentSSEModel.event = value;
              break;
            case 'data':
              currentSSEModel.data = currentSSEModel.data + value + '\n';
              break;
            case 'id':
              currentSSEModel.id = value;
              break;
            case 'retry':
              break;
          }
        });
      } catch (e) {
        BlitzLog().e(e);
        streamController.add(SSEModel(data: '', id: '', event: ''));
      }

      Future.delayed(const Duration(seconds: 1), () {});
      return streamController.stream.asBroadcastStream();
    }
  }

  static void unsubscribeFromSSE() {
    _client.close();
  }
}
