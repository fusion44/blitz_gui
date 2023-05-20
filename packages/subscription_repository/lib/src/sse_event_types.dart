part of 'subscription_repository.dart';

enum SseEventTypes {
  systemInfo,
  systemStartupInfo,
  hardwareInfo,
  install,
  installedAppStatus,
  btcInfo,
  btcNewBloc,
  btcNetworkStatus,
  btcMempoolStatus,
  lnInfo,
  lnInfoLite,
  lnInvoiceStatus,
  lnPaymentStatus,
  lnFeeRevenue,
  lnForwardSuccesses,
  walletBalance,
  walletLockStatus,
  unknown
}

List<SseEventTypes> allSSETypesExcept(List<SseEventTypes> excluded) {
  List<SseEventTypes> all = SseEventTypes.values.toList();
  all.removeWhere((e) => excluded.contains(e));

  return all;
}
