import 'dart:async';
import 'dart:convert';

import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:subscription_repository/subscription_repository.dart';

class FeeRevenueRepository {
  final AuthRepo _authRepo;
  final SubscriptionRepository _subRepo;
  late final Stream<Map<String, dynamic>> _stream;

  FeeRevenueRepository(this._subRepo, this._authRepo) {
    if (_subRepo.filteredStream([SseEventTypes.lnFeeRevenue]) == null) {
      throw StateError('SubscriptionRepo Stream is null');
    }
    _stream = _subRepo.filteredStream([SseEventTypes.lnFeeRevenue])!;
  }

  Stream<FeeRevenueData> revenueStream() {
    return _stream.map((event) {
      return FeeRevenueData.fromJson(event['data']);
    });
  }

  Future<FeeRevenueData?> currentRevenue() async {
    try {
      final url = '${_authRepo.baseUrl()}/latest/lightning/get-fee-revenue';
      final response = await fetch(Uri.parse(url), _authRepo.token());
      final b = FeeRevenueData.fromJson(jsonDecode(response.body));
      return b;
    } catch (e) {
      rethrow;
    }
  }
}
