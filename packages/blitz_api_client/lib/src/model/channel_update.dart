//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'channel_update.g.dart';

/// ChannelUpdate
///
/// Properties:
/// * [signature]
/// * [chainHash]
/// * [chanId]
/// * [timestamp]
/// * [messageFlags]
/// * [channelFlags]
/// * [timeLockDelta]
/// * [htlcMinimumMsat]
/// * [baseFee]
/// * [feeRate]
/// * [htlcMaximumMsat]
/// * [extraOpaqueData]
abstract class ChannelUpdate
    implements Built<ChannelUpdate, ChannelUpdateBuilder> {
  @BuiltValueField(wireName: r'signature')
  String get signature;

  @BuiltValueField(wireName: r'chain_hash')
  String get chainHash;

  @BuiltValueField(wireName: r'chan_id')
  int get chanId;

  @BuiltValueField(wireName: r'timestamp')
  int get timestamp;

  @BuiltValueField(wireName: r'message_flags')
  int get messageFlags;

  @BuiltValueField(wireName: r'channel_flags')
  int get channelFlags;

  @BuiltValueField(wireName: r'time_lock_delta')
  int get timeLockDelta;

  @BuiltValueField(wireName: r'htlc_minimum_msat')
  int get htlcMinimumMsat;

  @BuiltValueField(wireName: r'base_fee')
  int get baseFee;

  @BuiltValueField(wireName: r'fee_rate')
  int get feeRate;

  @BuiltValueField(wireName: r'htlc_maximum_msat')
  int get htlcMaximumMsat;

  @BuiltValueField(wireName: r'extra_opaque_data')
  String get extraOpaqueData;

  ChannelUpdate._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChannelUpdateBuilder b) => b;

  factory ChannelUpdate([void updates(ChannelUpdateBuilder b)]) =
      _$ChannelUpdate;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChannelUpdate> get serializer =>
      _$ChannelUpdateSerializer();
}

class _$ChannelUpdateSerializer implements StructuredSerializer<ChannelUpdate> {
  @override
  final Iterable<Type> types = const [ChannelUpdate, _$ChannelUpdate];

  @override
  final String wireName = r'ChannelUpdate';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChannelUpdate object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'signature')
      ..add(serializers.serialize(object.signature,
          specifiedType: const FullType(String)));
    result
      ..add(r'chain_hash')
      ..add(serializers.serialize(object.chainHash,
          specifiedType: const FullType(String)));
    result
      ..add(r'chan_id')
      ..add(serializers.serialize(object.chanId,
          specifiedType: const FullType(int)));
    result
      ..add(r'timestamp')
      ..add(serializers.serialize(object.timestamp,
          specifiedType: const FullType(int)));
    result
      ..add(r'message_flags')
      ..add(serializers.serialize(object.messageFlags,
          specifiedType: const FullType(int)));
    result
      ..add(r'channel_flags')
      ..add(serializers.serialize(object.channelFlags,
          specifiedType: const FullType(int)));
    result
      ..add(r'time_lock_delta')
      ..add(serializers.serialize(object.timeLockDelta,
          specifiedType: const FullType(int)));
    result
      ..add(r'htlc_minimum_msat')
      ..add(serializers.serialize(object.htlcMinimumMsat,
          specifiedType: const FullType(int)));
    result
      ..add(r'base_fee')
      ..add(serializers.serialize(object.baseFee,
          specifiedType: const FullType(int)));
    result
      ..add(r'fee_rate')
      ..add(serializers.serialize(object.feeRate,
          specifiedType: const FullType(int)));
    result
      ..add(r'htlc_maximum_msat')
      ..add(serializers.serialize(object.htlcMaximumMsat,
          specifiedType: const FullType(int)));
    result
      ..add(r'extra_opaque_data')
      ..add(serializers.serialize(object.extraOpaqueData,
          specifiedType: const FullType(String)));
    return result;
  }

  @override
  ChannelUpdate deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = ChannelUpdateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'signature':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.signature = valueDes;
          break;
        case r'chain_hash':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.chainHash = valueDes;
          break;
        case r'chan_id':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.chanId = valueDes;
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.timestamp = valueDes;
          break;
        case r'message_flags':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.messageFlags = valueDes;
          break;
        case r'channel_flags':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.channelFlags = valueDes;
          break;
        case r'time_lock_delta':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.timeLockDelta = valueDes;
          break;
        case r'htlc_minimum_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.htlcMinimumMsat = valueDes;
          break;
        case r'base_fee':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.baseFee = valueDes;
          break;
        case r'fee_rate':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.feeRate = valueDes;
          break;
        case r'htlc_maximum_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.htlcMaximumMsat = valueDes;
          break;
        case r'extra_opaque_data':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.extraOpaqueData = valueDes;
          break;
      }
    }
    return result.build();
  }
}
