// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';
import 'dart:async';

// https: //github.com/dart-lang/http/issues/593#issuecomment-880984594
Future<Stream<String>> establishSSEConnection(
  String url,
  String token,
) async {
  StreamController<String> streamController = StreamController();

  final httpReq = HttpRequest();
  int lastLength = 0;

  httpReq
    ..open('GET', url)
    ..setRequestHeader(
        'Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8')
    ..setRequestHeader('Cache-Control', 'text/event-stream')
    ..setRequestHeader('Accept', 'text/event-stream')
    ..setRequestHeader('Authorization', token)
    ..onProgress.listen((event) {
      if (httpReq.responseText != null) {
        final txt = httpReq.responseText ?? '';
        if (lastLength > 0) {
          var res = txt.substring(lastLength);
          var lines = res.split('\n');
          for (var i = 0; i < lines.length; i++) {
            streamController.add(lines[i].trim());
          }
        } else {
          streamController.add(txt);
        }

        lastLength = httpReq.responseText!.length;
      }
    })
    ..onLoadEnd.listen((event) {
      print('all done');
    })
    ..onError.listen((event) {
      print('all errors ${event}');
    })
    ..send('');

  return streamController.stream.asBroadcastStream();
}
