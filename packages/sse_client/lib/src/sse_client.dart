// From: https://pub.dev/packages/flutter_client_sse

library sse_client;

import 'dart:async';
import 'dart:convert';

import 'package:common/common.dart';
import 'package:http/http.dart' as http;

part 'sse_model.dart';

class SSEClient {
  static final http.Client _client = http.Client();
  static Stream<SSEModel> subscribeToSSE(String url, String token) {
    //Regex to be used
    var lineRegex = RegExp(r'^([^:]*)(?::)?(?: )?(.*)?$');
    //Creating a instance of the SSEModel
    var currentSSEModel = SSEModel(data: '', id: '', event: '');
    // ignore: close_sinks
    StreamController<SSEModel> streamController = StreamController();
    while (true) {
      try {
        var request = http.Request('GET', Uri.parse(url));
        //Adding headers to the request
        request.headers['Cache-Control'] = 'no-cache';
        request.headers['Accept'] = 'text/event-stream';
        request.headers['Authorization'] = token;
        Future<http.StreamedResponse> response = _client.send(request);

        //Listening to the response as a stream
        response.asStream().listen((data) {
          //Applying transforms and listening to it
          var _ = data.stream
            ..transform(const Utf8Decoder())
                .transform(const LineSplitter())
                .listen((dataLine) {
              if (dataLine.isEmpty) {
                //This means that the complete event set has been read.
                //We then add the event to the stream
                streamController.add(currentSSEModel);
                currentSSEModel = SSEModel(data: '', id: '', event: '');
                return;
              }

              if (data.statusCode != 200) {
                try {
                  final detail = jsonDecode(dataLine)['detail'];
                  BlitzLog().w(
                    'Error while connecting to the SSE endpoint with code ${data.statusCode}:\n$detail',
                  );
                } catch (e) {
                  BlitzLog().w(
                    'Unable to decode detail message of stream message error with code ${data.statusCode}:\n$dataLine',
                  );
                }

                return;
              }

              //Get the match of each line through the regex
              Match match = lineRegex.firstMatch(dataLine)!;
              var field = match.group(1);
              if (field!.isEmpty) {
                return;
              }
              var value = '';
              if (field == 'data') {
                //If the field is data, we get the data through the substring
                value = dataLine.substring(
                  6,
                );
              } else {
                value = match.group(2) ?? '';
              }
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
        });
      } catch (e) {
        BlitzLog().e(e);
        streamController.add(SSEModel(data: '', id: '', event: ''));
      }

      Future.delayed(const Duration(seconds: 1), () {});
      return streamController.stream;
    }
  }

  static void unsubscribeFromSSE() {
    _client.close();
  }
}
