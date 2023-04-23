//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/channel_update.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'htlc_attempt_failure.g.dart';

/// HTLCAttemptFailure
///
/// Properties:
/// * [code]
/// * [channelUpdate]
/// * [htlcMsat]
/// * [onionSha256]
/// * [cltvExpiry]
/// * [flags]
/// * [failureSourceIndex]
/// * [height]
abstract class HTLCAttemptFailure
    implements Built<HTLCAttemptFailure, HTLCAttemptFailureBuilder> {
  @BuiltValueField(wireName: r'code')
  int get code;

  @BuiltValueField(wireName: r'channel_update')
  ChannelUpdate get channelUpdate;

  @BuiltValueField(wireName: r'htlc_msat')
  int get htlcMsat;

  @BuiltValueField(wireName: r'onion_sha_256')
  String get onionSha256;

  @BuiltValueField(wireName: r'cltv_expiry')
  int get cltvExpiry;

  @BuiltValueField(wireName: r'flags')
  int get flags;

  @BuiltValueField(wireName: r'failure_source_index')
  int get failureSourceIndex;

  @BuiltValueField(wireName: r'height')
  int get height;

  HTLCAttemptFailure._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HTLCAttemptFailureBuilder b) => b;

  factory HTLCAttemptFailure([void updates(HTLCAttemptFailureBuilder b)]) =
      _$HTLCAttemptFailure;

  @BuiltValueSerializer(custom: true)
  static Serializer<HTLCAttemptFailure> get serializer =>
      _$HTLCAttemptFailureSerializer();
}

class _$HTLCAttemptFailureSerializer
    implements StructuredSerializer<HTLCAttemptFailure> {
  @override
  final Iterable<Type> types = const [HTLCAttemptFailure, _$HTLCAttemptFailure];

  @override
  final String wireName = r'HTLCAttemptFailure';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, HTLCAttemptFailure object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'code')
      ..add(serializers.serialize(object.code,
          specifiedType: const FullType(int)));
    result
      ..add(r'channel_update')
      ..add(serializers.serialize(object.channelUpdate,
          specifiedType: const FullType(ChannelUpdate)));
    result
      ..add(r'htlc_msat')
      ..add(serializers.serialize(object.htlcMsat,
          specifiedType: const FullType(int)));
    result
      ..add(r'onion_sha_256')
      ..add(serializers.serialize(object.onionSha256,
          specifiedType: const FullType(String)));
    result
      ..add(r'cltv_expiry')
      ..add(serializers.serialize(object.cltvExpiry,
          specifiedType: const FullType(int)));
    result
      ..add(r'flags')
      ..add(serializers.serialize(object.flags,
          specifiedType: const FullType(int)));
    result
      ..add(r'failure_source_index')
      ..add(serializers.serialize(object.failureSourceIndex,
          specifiedType: const FullType(int)));
    result
      ..add(r'height')
      ..add(serializers.serialize(object.height,
          specifiedType: const FullType(int)));
    return result;
  }

  @override
  HTLCAttemptFailure deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = HTLCAttemptFailureBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.code = valueDes;
          break;
        case r'channel_update':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(ChannelUpdate)) as ChannelUpdate;
          result.channelUpdate.replace(valueDes);
          break;
        case r'htlc_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.htlcMsat = valueDes;
          break;
        case r'onion_sha_256':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.onionSha256 = valueDes;
          break;
        case r'cltv_expiry':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.cltvExpiry = valueDes;
          break;
        case r'flags':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.flags = valueDes;
          break;
        case r'failure_source_index':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.failureSourceIndex = valueDes;
          break;
        case r'height':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.height = valueDes;
          break;
      }
    }
    return result.build();
  }
}
