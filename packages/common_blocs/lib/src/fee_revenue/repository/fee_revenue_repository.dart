import 'dart:async';
import 'dart:convert';

import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:subscription_repository/subscription_repository.dart';

class FeeRevenueRepository {
  late final Stream<Map<String, dynamic>> _stream;

  FeeRevenueRepository() {
    final subRepo = SubscriptionRepository.instanceChecked();

    _stream = subRepo.filteredStream([SseEventTypes.lnFeeRevenue])!;
  }

  Stream<FeeRevenueData> revenueStream() {
    return _stream.map((event) {
      return FeeRevenueData.fromJson(event['data']);
    });
  }

  Future<FeeRevenueData?> currentRevenue() async {
    final authRepo = AuthRepo.instanceChecked();
    try {
      final url = '${authRepo.baseUrl()}/latest/lightning/get-fee-revenue';
      final response = await fetch(Uri.parse(url), authRepo.token());
      final b = FeeRevenueData.fromJson(jsonDecode(response.body));
      return b;
    } catch (e) {
      rethrow;
    }
  }
}
