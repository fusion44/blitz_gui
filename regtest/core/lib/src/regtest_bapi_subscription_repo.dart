import 'dart:convert';

import 'package:sse_client/sse_client.dart';
import 'package:subscription_repository/subscription_repository.dart';

class RegtestBapiSubRepo {
  final String baseUrl;
  final String token;
  Stream<SSEModel>? _stream;

  bool _isInitialized = false;

  RegtestBapiSubRepo(this.baseUrl, this.token);

  bool get initialized => _isInitialized;

  Future<void> init() async {
    final url = '$baseUrl/sse/subscribe';
    try {
      _stream = await SSEClient.subscribeToSSE(url, token);
    } catch (e) {
      print('Unable to connect to the SEE endpoint. $e');
    }

    _isInitialized = true;
  }

  Stream<dynamic>? get rawStream => _stream;

  Stream<Map<String, dynamic>>? filteredStream(List<SseEventTypes> eventsIds) {
    if (eventsIds.isEmpty) {
      eventsIds = allSSETypesExcept(<SseEventTypes>[]);
    }

    var id;
    return _stream?.where((event) {
      try {
        id = _getEventId(event.event);
        if (eventsIds.contains(id)) return true;

        return false;
      } on UnknownSseTypeException {
        return false;
      }
    }).map<Map<String, dynamic>>(
      (event) => _parseEvent(event, id),
    );
  }

  Map<String, dynamic> _parseEvent(event, id) {
    try {
      return {
        'data': jsonDecode(event.data),
        'event': event.event,
        'id': id,
      };
    } on FormatException catch (_) {
      // Ping message?
      return <String, dynamic>{};
    }
  }

  SseEventTypes _getEventId(String? eventId) {
    if (eventId == 'system_info') {
      return SseEventTypes.systemInfo;
    } else if (eventId == 'system_startup_info') {
      return SseEventTypes.systemStartupInfo;
    } else if (eventId == 'hardware_info') {
      return SseEventTypes.hardwareInfo;
    } else if (eventId == 'install') {
      return SseEventTypes.install;
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
    } else if (eventId == 'ln_fee_revenue') {
      return SseEventTypes.lnFeeRevenue;
    } else if (eventId == 'ln_forward_successes') {
      return SseEventTypes.lnForwardSuccesses;
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
      return SseEventTypes.unknown;
    }
  }

  void dispose() => SSEClient.unsubscribeFromSSE();
}
