//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'btc_local_address.g.dart';

/// BtcLocalAddress
///
/// Properties:
/// * [address] - Network address
/// * [port] - Network port
/// * [score] - Relative score
abstract class BtcLocalAddress
    implements Built<BtcLocalAddress, BtcLocalAddressBuilder> {
  /// Network address
  @BuiltValueField(wireName: r'address')
  String get address;

  /// Network port
  @BuiltValueField(wireName: r'port')
  int get port;

  /// Relative score
  @BuiltValueField(wireName: r'score')
  int get score;

  BtcLocalAddress._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BtcLocalAddressBuilder b) => b;

  factory BtcLocalAddress([void updates(BtcLocalAddressBuilder b)]) =
      _$BtcLocalAddress;

  @BuiltValueSerializer(custom: true)
  static Serializer<BtcLocalAddress> get serializer =>
      _$BtcLocalAddressSerializer();
}

class _$BtcLocalAddressSerializer
    implements StructuredSerializer<BtcLocalAddress> {
  @override
  final Iterable<Type> types = const [BtcLocalAddress, _$BtcLocalAddress];

  @override
  final String wireName = r'BtcLocalAddress';

  @override
  Iterable<Object?> serialize(Serializers serializers, BtcLocalAddress object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'address')
      ..add(serializers.serialize(object.address,
          specifiedType: const FullType(String)));
    result
      ..add(r'port')
      ..add(serializers.serialize(object.port,
          specifiedType: const FullType(int)));
    result
      ..add(r'score')
      ..add(serializers.serialize(object.score,
          specifiedType: const FullType(int)));
    return result;
  }

  @override
  BtcLocalAddress deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = BtcLocalAddressBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'address':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.address = valueDes;
          break;
        case r'port':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.port = valueDes;
          break;
        case r'score':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.score = valueDes;
          break;
      }
    }
    return result.build();
  }
}
