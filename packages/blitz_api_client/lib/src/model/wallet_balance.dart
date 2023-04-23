//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_balance.g.dart';

/// WalletBalance
///
/// Properties:
/// * [onchainConfirmedBalance] - Confirmed onchain balance (more than three confirmations) in sat
/// * [onchainTotalBalance] - Total combined onchain balance in sat
/// * [onchainUnconfirmedBalance] - Unconfirmed onchain balance (less than three confirmations) in sat
/// * [channelLocalBalance] - Sum of channels local balances in msat
/// * [channelRemoteBalance] - Sum of channels remote balances in msat.
/// * [channelUnsettledLocalBalance] - Sum of channels local unsettled balances in msat.
/// * [channelUnsettledRemoteBalance] - Sum of channels remote unsettled balances in msat.
/// * [channelPendingOpenLocalBalance] - Sum of channels pending local balances in msat.
/// * [channelPendingOpenRemoteBalance] - Sum of channels pending remote balances in msat.
abstract class WalletBalance
    implements Built<WalletBalance, WalletBalanceBuilder> {
  /// Confirmed onchain balance (more than three confirmations) in sat
  @BuiltValueField(wireName: r'onchain_confirmed_balance')
  int get onchainConfirmedBalance;

  /// Total combined onchain balance in sat
  @BuiltValueField(wireName: r'onchain_total_balance')
  int get onchainTotalBalance;

  /// Unconfirmed onchain balance (less than three confirmations) in sat
  @BuiltValueField(wireName: r'onchain_unconfirmed_balance')
  int get onchainUnconfirmedBalance;

  /// Sum of channels local balances in msat
  @BuiltValueField(wireName: r'channel_local_balance')
  int get channelLocalBalance;

  /// Sum of channels remote balances in msat.
  @BuiltValueField(wireName: r'channel_remote_balance')
  int get channelRemoteBalance;

  /// Sum of channels local unsettled balances in msat.
  @BuiltValueField(wireName: r'channel_unsettled_local_balance')
  int get channelUnsettledLocalBalance;

  /// Sum of channels remote unsettled balances in msat.
  @BuiltValueField(wireName: r'channel_unsettled_remote_balance')
  int get channelUnsettledRemoteBalance;

  /// Sum of channels pending local balances in msat.
  @BuiltValueField(wireName: r'channel_pending_open_local_balance')
  int get channelPendingOpenLocalBalance;

  /// Sum of channels pending remote balances in msat.
  @BuiltValueField(wireName: r'channel_pending_open_remote_balance')
  int get channelPendingOpenRemoteBalance;

  WalletBalance._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WalletBalanceBuilder b) => b;

  factory WalletBalance([void updates(WalletBalanceBuilder b)]) =
      _$WalletBalance;

  @BuiltValueSerializer(custom: true)
  static Serializer<WalletBalance> get serializer =>
      _$WalletBalanceSerializer();
}

class _$WalletBalanceSerializer implements StructuredSerializer<WalletBalance> {
  @override
  final Iterable<Type> types = const [WalletBalance, _$WalletBalance];

  @override
  final String wireName = r'WalletBalance';

  @override
  Iterable<Object?> serialize(Serializers serializers, WalletBalance object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'onchain_confirmed_balance')
      ..add(serializers.serialize(object.onchainConfirmedBalance,
          specifiedType: const FullType(int)));
    result
      ..add(r'onchain_total_balance')
      ..add(serializers.serialize(object.onchainTotalBalance,
          specifiedType: const FullType(int)));
    result
      ..add(r'onchain_unconfirmed_balance')
      ..add(serializers.serialize(object.onchainUnconfirmedBalance,
          specifiedType: const FullType(int)));
    result
      ..add(r'channel_local_balance')
      ..add(serializers.serialize(object.channelLocalBalance,
          specifiedType: const FullType(int)));
    result
      ..add(r'channel_remote_balance')
      ..add(serializers.serialize(object.channelRemoteBalance,
          specifiedType: const FullType(int)));
    result
      ..add(r'channel_unsettled_local_balance')
      ..add(serializers.serialize(object.channelUnsettledLocalBalance,
          specifiedType: const FullType(int)));
    result
      ..add(r'channel_unsettled_remote_balance')
      ..add(serializers.serialize(object.channelUnsettledRemoteBalance,
          specifiedType: const FullType(int)));
    result
      ..add(r'channel_pending_open_local_balance')
      ..add(serializers.serialize(object.channelPendingOpenLocalBalance,
          specifiedType: const FullType(int)));
    result
      ..add(r'channel_pending_open_remote_balance')
      ..add(serializers.serialize(object.channelPendingOpenRemoteBalance,
          specifiedType: const FullType(int)));
    return result;
  }

  @override
  WalletBalance deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = WalletBalanceBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'onchain_confirmed_balance':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.onchainConfirmedBalance = valueDes;
          break;
        case r'onchain_total_balance':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.onchainTotalBalance = valueDes;
          break;
        case r'onchain_unconfirmed_balance':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.onchainUnconfirmedBalance = valueDes;
          break;
        case r'channel_local_balance':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.channelLocalBalance = valueDes;
          break;
        case r'channel_remote_balance':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.channelRemoteBalance = valueDes;
          break;
        case r'channel_unsettled_local_balance':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.channelUnsettledLocalBalance = valueDes;
          break;
        case r'channel_unsettled_remote_balance':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.channelUnsettledRemoteBalance = valueDes;
          break;
        case r'channel_pending_open_local_balance':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.channelPendingOpenLocalBalance = valueDes;
          break;
        case r'channel_pending_open_remote_balance':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.channelPendingOpenRemoteBalance = valueDes;
          break;
      }
    }
    return result.build();
  }
}
