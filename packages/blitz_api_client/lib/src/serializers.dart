//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:blitz_api_client/src/date_serializer.dart';
import 'package:blitz_api_client/src/model/amp.dart';
import 'package:blitz_api_client/src/model/amp1.dart';
import 'package:blitz_api_client/src/model/amp_record.dart';
import 'package:blitz_api_client/src/model/api_platform.dart';
import 'package:blitz_api_client/src/model/bip9.dart';
import 'package:blitz_api_client/src/model/bip9_data.dart';
import 'package:blitz_api_client/src/model/bip9_statistics.dart';
import 'package:blitz_api_client/src/model/blockchain_info.dart';
import 'package:blitz_api_client/src/model/btc_info.dart';
import 'package:blitz_api_client/src/model/btc_local_address.dart';
import 'package:blitz_api_client/src/model/btc_network.dart';
import 'package:blitz_api_client/src/model/chain.dart';
import 'package:blitz_api_client/src/model/channel.dart';
import 'package:blitz_api_client/src/model/channel_initiator.dart';
import 'package:blitz_api_client/src/model/channel_state.dart';
import 'package:blitz_api_client/src/model/channel_update.dart';
import 'package:blitz_api_client/src/model/connection_info.dart';
import 'package:blitz_api_client/src/model/custom_records_entry.dart';
import 'package:blitz_api_client/src/model/date.dart';
import 'package:blitz_api_client/src/model/feature.dart';
import 'package:blitz_api_client/src/model/features_entry.dart';
import 'package:blitz_api_client/src/model/fee_estimation_mode.dart';
import 'package:blitz_api_client/src/model/fee_revenue.dart';
import 'package:blitz_api_client/src/model/generic_tx.dart';
import 'package:blitz_api_client/src/model/hop.dart';
import 'package:blitz_api_client/src/model/hop_hint.dart';
import 'package:blitz_api_client/src/model/htlc_attempt.dart';
import 'package:blitz_api_client/src/model/htlc_attempt_failure.dart';
import 'package:blitz_api_client/src/model/htlc_status.dart';
import 'package:blitz_api_client/src/model/http_validation_error.dart';
import 'package:blitz_api_client/src/model/invoice.dart';
import 'package:blitz_api_client/src/model/invoice_htlc.dart';
import 'package:blitz_api_client/src/model/invoice_htlc_state.dart';
import 'package:blitz_api_client/src/model/invoice_state.dart';
import 'package:blitz_api_client/src/model/lightning_info_lite.dart';
import 'package:blitz_api_client/src/model/ln_info.dart';
import 'package:blitz_api_client/src/model/location_inner.dart';
import 'package:blitz_api_client/src/model/login_input.dart';
import 'package:blitz_api_client/src/model/mpp_record.dart';
import 'package:blitz_api_client/src/model/network_info.dart';
import 'package:blitz_api_client/src/model/new_address_input.dart';
import 'package:blitz_api_client/src/model/on_chain_transaction.dart';
import 'package:blitz_api_client/src/model/onchain_address_type.dart';
import 'package:blitz_api_client/src/model/payment.dart';
import 'package:blitz_api_client/src/model/payment_failure_reason.dart';
import 'package:blitz_api_client/src/model/payment_request.dart';
import 'package:blitz_api_client/src/model/payment_status.dart';
import 'package:blitz_api_client/src/model/raw_debug_log_data.dart';
import 'package:blitz_api_client/src/model/raw_transaction.dart';
import 'package:blitz_api_client/src/model/route.dart';
import 'package:blitz_api_client/src/model/route_hint.dart';
import 'package:blitz_api_client/src/model/send_coins_input.dart';
import 'package:blitz_api_client/src/model/send_coins_response.dart';
import 'package:blitz_api_client/src/model/soft_fork.dart';
import 'package:blitz_api_client/src/model/statistics.dart';
import 'package:blitz_api_client/src/model/system_info.dart';
import 'package:blitz_api_client/src/model/tx_category.dart';
import 'package:blitz_api_client/src/model/tx_status.dart';
import 'package:blitz_api_client/src/model/tx_type.dart';
import 'package:blitz_api_client/src/model/uninstall_data.dart';
import 'package:blitz_api_client/src/model/unlock_wallet_input.dart';
import 'package:blitz_api_client/src/model/validation_error.dart';
import 'package:blitz_api_client/src/model/wallet_balance.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'serializers.g.dart';

@SerializersFor([
  AMPRecord,
  APIPlatform,
  Amp,
  Amp1,
  Bip9,
  Bip9Data,
  Bip9Statistics,
  BlockchainInfo,
  BtcInfo,
  BtcLocalAddress,
  BtcNetwork,
  Chain,
  Channel,
  ChannelInitiator,
  ChannelState,
  ChannelUpdate,
  ConnectionInfo,
  CustomRecordsEntry,
  Feature,
  FeaturesEntry,
  FeeEstimationMode,
  FeeRevenue,
  GenericTx,
  HTLCAttempt,
  HTLCAttemptFailure,
  HTLCStatus,
  HTTPValidationError,
  Hop,
  HopHint,
  Invoice,
  InvoiceHTLC,
  InvoiceHTLCState,
  InvoiceState,
  LightningInfoLite,
  LnInfo,
  LocationInner,
  LoginInput,
  MPPRecord,
  NetworkInfo,
  NewAddressInput,
  OnChainTransaction,
  OnchainAddressType,
  Payment,
  PaymentFailureReason,
  PaymentRequest,
  PaymentStatus,
  RawDebugLogData,
  RawTransaction,
  Route,
  RouteHint,
  SendCoinsInput,
  SendCoinsResponse,
  SoftFork,
  Statistics,
  SystemInfo,
  TxCategory,
  TxStatus,
  TxType,
  UninstallData,
  UnlockWalletInput,
  ValidationError,
  WalletBalance,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(OnChainTransaction)]),
        () => ListBuilder<OnChainTransaction>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(GenericTx)]),
        () => ListBuilder<GenericTx>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Channel)]),
        () => ListBuilder<Channel>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Invoice)]),
        () => ListBuilder<Invoice>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Payment)]),
        () => ListBuilder<Payment>(),
      )
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
