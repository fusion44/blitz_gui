import 'dart:async';
import 'dart:convert';

import 'package:sse_client/sse_client.dart';

enum SseEventTypes {
  sysStatus,
  btcInfo,
  btcNewBloc,
  btcNetworkStatus,
  btcMempoolStatus,
  lnInfo,
  lnInvoiceStatus,
  walletBalance,
  unknown
}

class SubscriptionRepository {
  SseClient? _client;
  Stream? _stream;

  SubscriptionRepository() {
    _client = SseClient.connect(
      Uri.parse('http://127.0.0.1:8000/sse/subscribe'),
    );
    _stream = _client?.stream?.asBroadcastStream();
  }

  Stream<Map<String, dynamic>>? filteredStream(List<SseEventTypes> eventsIds) {
    return _stream?.map<Map<String, dynamic>>((event) {
      try {
        return jsonDecode(event);
      } on FormatException {
        // Ping message?
        return <String, dynamic>{};
      }
    }).where((event) {
      final id = _getEventId(event['id']);
      if (eventsIds.contains(id)) return true;
      return false;
    });
  }

  Stream<dynamic>? get rawStream => _stream;

  SseEventTypes _getEventId(dynamic eventId) {
    if (eventId == 'sys_status') {
      return SseEventTypes.sysStatus;
    } else if (eventId == 'btc_info') {
      return SseEventTypes.btcInfo;
    } else if (eventId == 'btc_new_bloc') {
      return SseEventTypes.btcNewBloc;
    } else if (eventId == 'btc_network_status') {
      return SseEventTypes.btcNetworkStatus;
    } else if (eventId == 'btc_mempool_status') {
      return SseEventTypes.btcMempoolStatus;
    } else if (eventId == 'ln_info') {
      return SseEventTypes.lnInfo;
    } else if (eventId == 'ln_invoice_status') {
      return SseEventTypes.lnInvoiceStatus;
    } else if (eventId == 'wallet_balance') {
      return SseEventTypes.walletBalance;
    } else {
      return SseEventTypes.unknown;
    }
  }
}
