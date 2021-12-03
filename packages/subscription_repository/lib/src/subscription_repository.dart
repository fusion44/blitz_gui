import 'dart:async';
import 'dart:convert';

import 'package:common/common.dart';
import 'package:sse_client/sse_client.dart';

part 'exceptions.dart';
part 'sse_event_types.dart';

class SubscriptionRepository {
  final String baseUrl;
  final String token;
  Stream<SSEModel>? _stream;

  SubscriptionRepository(this.baseUrl, this.token) {
    final url = '$baseUrl/sse/subscribe';
    try {
      _stream = SSEClient.subscribeToSSE(
        url,
        token,
      ).asBroadcastStream();
    } catch (e) {
      BlitzLog().w('Unable to connect to the SEE endpoint. $e');
    }
  }

  Stream<dynamic>? get rawStream => _stream;

  Stream<Map<String, dynamic>>? filteredStream(List<SseEventTypes> eventsIds) {
    return _stream?.where((event) {
      try {
        final id = _getEventId(event.event);
        if (eventsIds.contains(id)) return true;
        return false;
      } on UnknownSseTypeException {
        return false;
      }
    }).map<Map<String, dynamic>>((event) {
      try {
        return {
          'data': jsonDecode(event.data),
          'event': event.event,
        };
      } on FormatException catch (e) {
        // Ping message?
        BlitzLog().e(e);
        return <String, dynamic>{};
      }
    });
  }

  SseEventTypes _getEventId(String? eventId) {
    if (eventId == 'system_info') {
      return SseEventTypes.systemInfo;
    } else if (eventId == 'hardware_info') {
      return SseEventTypes.hardwareInfo;
    } else if (eventId == 'installed_app_status') {
      return SseEventTypes.installedAppStatus;
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
    } else if (eventId == 'ln_info_lite') {
      return SseEventTypes.lnInfoLite;
    } else if (eventId == 'ln_invoice_status') {
      return SseEventTypes.lnInvoiceStatus;
    } else if (eventId == 'ln_payment_status') {
      return SseEventTypes.lnPaymentStatus;
    } else if (eventId == 'wallet_balance') {
      return SseEventTypes.walletBalance;
    } else if (eventId == 'wallet_lock_status') {
      return SseEventTypes.walletLockStatus;
    } else {
      throw UnknownSseTypeException.withDefaultMessage(eventId);
    }
  }
}
