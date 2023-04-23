//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'btc_network.g.dart';

/// BtcNetwork
///
/// Properties:
/// * [name] - Which network is in use (ipv4, ipv6 or onion)
/// * [limited] - Is the network limited using - onlynet?
/// * [reachable] - Is the network reachable?
/// * [proxy] - host:port of the proxy that is used for this network, or empty if none
/// * [proxyRandomizeCredentials] - Whether randomized credentials are used
abstract class BtcNetwork implements Built<BtcNetwork, BtcNetworkBuilder> {
  /// Which network is in use (ipv4, ipv6 or onion)
  @BuiltValueField(wireName: r'name')
  String get name;

  /// Is the network limited using - onlynet?
  @BuiltValueField(wireName: r'limited')
  bool get limited;

  /// Is the network reachable?
  @BuiltValueField(wireName: r'reachable')
  bool get reachable;

  /// host:port of the proxy that is used for this network, or empty if none
  @BuiltValueField(wireName: r'proxy')
  String? get proxy;

  /// Whether randomized credentials are used
  @BuiltValueField(wireName: r'proxy_randomize_credentials')
  bool get proxyRandomizeCredentials;

  BtcNetwork._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BtcNetworkBuilder b) => b..proxy = '';

  factory BtcNetwork([void updates(BtcNetworkBuilder b)]) = _$BtcNetwork;

  @BuiltValueSerializer(custom: true)
  static Serializer<BtcNetwork> get serializer => _$BtcNetworkSerializer();
}

class _$BtcNetworkSerializer implements StructuredSerializer<BtcNetwork> {
  @override
  final Iterable<Type> types = const [BtcNetwork, _$BtcNetwork];

  @override
  final String wireName = r'BtcNetwork';

  @override
  Iterable<Object?> serialize(Serializers serializers, BtcNetwork object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'name')
      ..add(serializers.serialize(object.name,
          specifiedType: const FullType(String)));
    result
      ..add(r'limited')
      ..add(serializers.serialize(object.limited,
          specifiedType: const FullType(bool)));
    result
      ..add(r'reachable')
      ..add(serializers.serialize(object.reachable,
          specifiedType: const FullType(bool)));
    if (object.proxy != null) {
      result
        ..add(r'proxy')
        ..add(serializers.serialize(object.proxy,
            specifiedType: const FullType(String)));
    }
    result
      ..add(r'proxy_randomize_credentials')
      ..add(serializers.serialize(object.proxyRandomizeCredentials,
          specifiedType: const FullType(bool)));
    return result;
  }

  @override
  BtcNetwork deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = BtcNetworkBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.name = valueDes;
          break;
        case r'limited':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.limited = valueDes;
          break;
        case r'reachable':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.reachable = valueDes;
          break;
        case r'proxy':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.proxy = valueDes;
          break;
        case r'proxy_randomize_credentials':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.proxyRandomizeCredentials = valueDes;
          break;
      }
    }
    return result.build();
  }
}
