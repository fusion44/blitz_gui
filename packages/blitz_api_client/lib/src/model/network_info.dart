//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/btc_local_address.dart';
import 'package:blitz_api_client/src/model/btc_network.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'network_info.g.dart';

/// NetworkInfo
///
/// Properties:
/// * [version] - The bitcoin core server version
/// * [subversion] - The server subversion string
/// * [protocolVersion] - The protocol version
/// * [localServices] - The services we offer to the network, hex formatted
/// * [localServicesNames] - The services we offer to the network, in human-readable form
/// * [localRelay] - True if transaction relay is requested from peers
/// * [timeOffset] - The time offset
/// * [connections] - The total number of connections
/// * [connectionsIn] - The number of inbound connections
/// * [connectionsOut] - The number of outbound connections
/// * [networkActive] - Whether p2p networking is enabled
/// * [networks] - Information per network
/// * [relayFee] - Minimum relay fee for transactions in BTC/kB
/// * [incrementalFee] - Minimum fee increment for mempool limiting or BIP 125 replacement in BTC/kB
/// * [localAddresses] - List of local addresses
/// * [warnings] - Any network and blockchain warnings
abstract class NetworkInfo implements Built<NetworkInfo, NetworkInfoBuilder> {
  /// The bitcoin core server version
  @BuiltValueField(wireName: r'version')
  int get version;

  /// The server subversion string
  @BuiltValueField(wireName: r'subversion')
  String get subversion;

  /// The protocol version
  @BuiltValueField(wireName: r'protocol_version')
  int get protocolVersion;

  /// The services we offer to the network, hex formatted
  @BuiltValueField(wireName: r'local_services')
  String? get localServices;

  /// The services we offer to the network, in human-readable form
  @BuiltValueField(wireName: r'local_services_names')
  BuiltList<String>? get localServicesNames;

  /// True if transaction relay is requested from peers
  @BuiltValueField(wireName: r'local_relay')
  bool get localRelay;

  /// The time offset
  @BuiltValueField(wireName: r'time_offset')
  int get timeOffset;

  /// The total number of connections
  @BuiltValueField(wireName: r'connections')
  int get connections;

  /// The number of inbound connections
  @BuiltValueField(wireName: r'connections_in')
  int get connectionsIn;

  /// The number of outbound connections
  @BuiltValueField(wireName: r'connections_out')
  int get connectionsOut;

  /// Whether p2p networking is enabled
  @BuiltValueField(wireName: r'network_active')
  bool get networkActive;

  /// Information per network
  @BuiltValueField(wireName: r'networks')
  BuiltList<BtcNetwork> get networks;

  /// Minimum relay fee for transactions in BTC/kB
  @BuiltValueField(wireName: r'relay_fee')
  int get relayFee;

  /// Minimum fee increment for mempool limiting or BIP 125 replacement in BTC/kB
  @BuiltValueField(wireName: r'incremental_fee')
  int get incrementalFee;

  /// List of local addresses
  @BuiltValueField(wireName: r'local_addresses')
  BuiltList<BtcLocalAddress>? get localAddresses;

  /// Any network and blockchain warnings
  @BuiltValueField(wireName: r'warnings')
  String? get warnings;

  NetworkInfo._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NetworkInfoBuilder b) => b
    ..localServicesNames = ListBuilder()
    ..localAddresses = ListBuilder();

  factory NetworkInfo([void updates(NetworkInfoBuilder b)]) = _$NetworkInfo;

  @BuiltValueSerializer(custom: true)
  static Serializer<NetworkInfo> get serializer => _$NetworkInfoSerializer();
}

class _$NetworkInfoSerializer implements StructuredSerializer<NetworkInfo> {
  @override
  final Iterable<Type> types = const [NetworkInfo, _$NetworkInfo];

  @override
  final String wireName = r'NetworkInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, NetworkInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'version')
      ..add(serializers.serialize(object.version,
          specifiedType: const FullType(int)));
    result
      ..add(r'subversion')
      ..add(serializers.serialize(object.subversion,
          specifiedType: const FullType(String)));
    result
      ..add(r'protocol_version')
      ..add(serializers.serialize(object.protocolVersion,
          specifiedType: const FullType(int)));
    if (object.localServices != null) {
      result
        ..add(r'local_services')
        ..add(serializers.serialize(object.localServices,
            specifiedType: const FullType(String)));
    }
    if (object.localServicesNames != null) {
      result
        ..add(r'local_services_names')
        ..add(serializers.serialize(object.localServicesNames,
            specifiedType: const FullType(BuiltList, [FullType(String)])));
    }
    result
      ..add(r'local_relay')
      ..add(serializers.serialize(object.localRelay,
          specifiedType: const FullType(bool)));
    result
      ..add(r'time_offset')
      ..add(serializers.serialize(object.timeOffset,
          specifiedType: const FullType(int)));
    result
      ..add(r'connections')
      ..add(serializers.serialize(object.connections,
          specifiedType: const FullType(int)));
    result
      ..add(r'connections_in')
      ..add(serializers.serialize(object.connectionsIn,
          specifiedType: const FullType(int)));
    result
      ..add(r'connections_out')
      ..add(serializers.serialize(object.connectionsOut,
          specifiedType: const FullType(int)));
    result
      ..add(r'network_active')
      ..add(serializers.serialize(object.networkActive,
          specifiedType: const FullType(bool)));
    result
      ..add(r'networks')
      ..add(serializers.serialize(object.networks,
          specifiedType: const FullType(BuiltList, [FullType(BtcNetwork)])));
    result
      ..add(r'relay_fee')
      ..add(serializers.serialize(object.relayFee,
          specifiedType: const FullType(int)));
    result
      ..add(r'incremental_fee')
      ..add(serializers.serialize(object.incrementalFee,
          specifiedType: const FullType(int)));
    if (object.localAddresses != null) {
      result
        ..add(r'local_addresses')
        ..add(serializers.serialize(object.localAddresses,
            specifiedType:
                const FullType(BuiltList, [FullType(BtcLocalAddress)])));
    }
    if (object.warnings != null) {
      result
        ..add(r'warnings')
        ..add(serializers.serialize(object.warnings,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  NetworkInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = NetworkInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'version':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.version = valueDes;
          break;
        case r'subversion':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.subversion = valueDes;
          break;
        case r'protocol_version':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.protocolVersion = valueDes;
          break;
        case r'local_services':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.localServices = valueDes;
          break;
        case r'local_services_names':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType(BuiltList, [FullType(String)]))
              as BuiltList<String>;
          result.localServicesNames.replace(valueDes);
          break;
        case r'local_relay':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.localRelay = valueDes;
          break;
        case r'time_offset':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.timeOffset = valueDes;
          break;
        case r'connections':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.connections = valueDes;
          break;
        case r'connections_in':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.connectionsIn = valueDes;
          break;
        case r'connections_out':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.connectionsOut = valueDes;
          break;
        case r'network_active':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.networkActive = valueDes;
          break;
        case r'networks':
          final valueDes = serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, [FullType(BtcNetwork)]))
              as BuiltList<BtcNetwork>;
          result.networks.replace(valueDes);
          break;
        case r'relay_fee':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.relayFee = valueDes;
          break;
        case r'incremental_fee':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.incrementalFee = valueDes;
          break;
        case r'local_addresses':
          final valueDes = serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, [FullType(BtcLocalAddress)]))
              as BuiltList<BtcLocalAddress>;
          result.localAddresses.replace(valueDes);
          break;
        case r'warnings':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.warnings = valueDes;
          break;
      }
    }
    return result.build();
  }
}
