//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/btc_network.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'btc_info.g.dart';

/// BtcInfo
///
/// Properties:
/// * [blocks] - The height of the most-work fully-validated chain. The genesis block has height 0
/// * [headers] - The current number of headers we have validated
/// * [verificationProgress] - Estimate of verification progress[0..1]
/// * [difficulty] - The current difficulty
/// * [sizeOnDisk] - The estimated size of the block and undo files on disk
/// * [networks] - Which networks are in use (ipv4, ipv6 or onion)
/// * [version] - The bitcoin core server version
/// * [subversion] - The server subversion string
/// * [connectionsIn] - The number of inbound connections
/// * [connectionsOut] - The number of outbound connections
abstract class BtcInfo implements Built<BtcInfo, BtcInfoBuilder> {
  /// The height of the most-work fully-validated chain. The genesis block has height 0
  @BuiltValueField(wireName: r'blocks')
  int get blocks;

  /// The current number of headers we have validated
  @BuiltValueField(wireName: r'headers')
  int get headers;

  /// Estimate of verification progress[0..1]
  @BuiltValueField(wireName: r'verification_progress')
  num get verificationProgress;

  /// The current difficulty
  @BuiltValueField(wireName: r'difficulty')
  int get difficulty;

  /// The estimated size of the block and undo files on disk
  @BuiltValueField(wireName: r'size_on_disk')
  int get sizeOnDisk;

  /// Which networks are in use (ipv4, ipv6 or onion)
  @BuiltValueField(wireName: r'networks')
  BuiltList<BtcNetwork>? get networks;

  /// The bitcoin core server version
  @BuiltValueField(wireName: r'version')
  int get version;

  /// The server subversion string
  @BuiltValueField(wireName: r'subversion')
  String get subversion;

  /// The number of inbound connections
  @BuiltValueField(wireName: r'connections_in')
  int get connectionsIn;

  /// The number of outbound connections
  @BuiltValueField(wireName: r'connections_out')
  int get connectionsOut;

  BtcInfo._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BtcInfoBuilder b) => b..networks = ListBuilder();

  factory BtcInfo([void updates(BtcInfoBuilder b)]) = _$BtcInfo;

  @BuiltValueSerializer(custom: true)
  static Serializer<BtcInfo> get serializer => _$BtcInfoSerializer();
}

class _$BtcInfoSerializer implements StructuredSerializer<BtcInfo> {
  @override
  final Iterable<Type> types = const [BtcInfo, _$BtcInfo];

  @override
  final String wireName = r'BtcInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, BtcInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'blocks')
      ..add(serializers.serialize(object.blocks,
          specifiedType: const FullType(int)));
    result
      ..add(r'headers')
      ..add(serializers.serialize(object.headers,
          specifiedType: const FullType(int)));
    result
      ..add(r'verification_progress')
      ..add(serializers.serialize(object.verificationProgress,
          specifiedType: const FullType(num)));
    result
      ..add(r'difficulty')
      ..add(serializers.serialize(object.difficulty,
          specifiedType: const FullType(int)));
    result
      ..add(r'size_on_disk')
      ..add(serializers.serialize(object.sizeOnDisk,
          specifiedType: const FullType(int)));
    if (object.networks != null) {
      result
        ..add(r'networks')
        ..add(serializers.serialize(object.networks,
            specifiedType: const FullType(BuiltList, [FullType(BtcNetwork)])));
    }
    result
      ..add(r'version')
      ..add(serializers.serialize(object.version,
          specifiedType: const FullType(int)));
    result
      ..add(r'subversion')
      ..add(serializers.serialize(object.subversion,
          specifiedType: const FullType(String)));
    result
      ..add(r'connections_in')
      ..add(serializers.serialize(object.connectionsIn,
          specifiedType: const FullType(int)));
    result
      ..add(r'connections_out')
      ..add(serializers.serialize(object.connectionsOut,
          specifiedType: const FullType(int)));
    return result;
  }

  @override
  BtcInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = BtcInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'blocks':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.blocks = valueDes;
          break;
        case r'headers':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.headers = valueDes;
          break;
        case r'verification_progress':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          result.verificationProgress = valueDes;
          break;
        case r'difficulty':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.difficulty = valueDes;
          break;
        case r'size_on_disk':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.sizeOnDisk = valueDes;
          break;
        case r'networks':
          final valueDes = serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, [FullType(BtcNetwork)]))
              as BuiltList<BtcNetwork>;
          result.networks.replace(valueDes);
          break;
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
      }
    }
    return result.build();
  }
}
