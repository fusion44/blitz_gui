part of 'subscription_repository.dart';

enum SseEventTypes {
  systemInfo,
  hardwareInfo,
  installedAppStatus,
  btcInfo,
  btcNewBloc,
  btcNetworkStatus,
  btcMempoolStatus,
  lnInfo,
  lnInfoLite,
  lnInvoiceStatus,
  lnPaymentStatus,
  walletBalance,
  walletLockStatus,
  unknown
}
