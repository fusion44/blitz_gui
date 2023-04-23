//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/statistics.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bip9_data.g.dart';

/// Bip9Data
///
/// Properties:
/// * [status] - One of \"defined\", \"started\", \"locked_in\", \"active\", \"failed\"
/// * [bit] - the bit(0-28) in the block version field used to signal this softfork(only for `started` status)
/// * [startTime] - The minimum median time past of a block at which the bit gains its meaning
/// * [timeout] - The median time past of a block at which the deployment is considered failed if not yet locked in
/// * [since] - Height of the first block to which the status applies
/// * [minActivationHeight] - Minimum height of blocks for which the rules may be enforced
/// * [statistics]
/// * [height] - Height of the first block which the rules are or will be enforced(only for `buried` type, or `bip9` type with `active` status)
/// * [active] - True if the rules are enforced for the mempool and the next block
abstract class Bip9Data implements Built<Bip9Data, Bip9DataBuilder> {
  /// One of \"defined\", \"started\", \"locked_in\", \"active\", \"failed\"
  @BuiltValueField(wireName: r'status')
  String get status;

  /// the bit(0-28) in the block version field used to signal this softfork(only for `started` status)
  @BuiltValueField(wireName: r'bit')
  int? get bit;

  /// The minimum median time past of a block at which the bit gains its meaning
  @BuiltValueField(wireName: r'start_time')
  int get startTime;

  /// The median time past of a block at which the deployment is considered failed if not yet locked in
  @BuiltValueField(wireName: r'timeout')
  int get timeout;

  /// Height of the first block to which the status applies
  @BuiltValueField(wireName: r'since')
  int get since;

  /// Minimum height of blocks for which the rules may be enforced
  @BuiltValueField(wireName: r'min_activation_height')
  int get minActivationHeight;

  @BuiltValueField(wireName: r'statistics')
  Statistics? get statistics;

  /// Height of the first block which the rules are or will be enforced(only for `buried` type, or `bip9` type with `active` status)
  @BuiltValueField(wireName: r'height')
  int? get height;

  /// True if the rules are enforced for the mempool and the next block
  @BuiltValueField(wireName: r'active')
  bool? get active;

  Bip9Data._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Bip9DataBuilder b) => b;

  factory Bip9Data([void updates(Bip9DataBuilder b)]) = _$Bip9Data;

  @BuiltValueSerializer(custom: true)
  static Serializer<Bip9Data> get serializer => _$Bip9DataSerializer();
}

class _$Bip9DataSerializer implements StructuredSerializer<Bip9Data> {
  @override
  final Iterable<Type> types = const [Bip9Data, _$Bip9Data];

  @override
  final String wireName = r'Bip9Data';

  @override
  Iterable<Object?> serialize(Serializers serializers, Bip9Data object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'status')
      ..add(serializers.serialize(object.status,
          specifiedType: const FullType(String)));
    if (object.bit != null) {
      result
        ..add(r'bit')
        ..add(serializers.serialize(object.bit,
            specifiedType: const FullType(int)));
    }
    result
      ..add(r'start_time')
      ..add(serializers.serialize(object.startTime,
          specifiedType: const FullType(int)));
    result
      ..add(r'timeout')
      ..add(serializers.serialize(object.timeout,
          specifiedType: const FullType(int)));
    result
      ..add(r'since')
      ..add(serializers.serialize(object.since,
          specifiedType: const FullType(int)));
    result
      ..add(r'min_activation_height')
      ..add(serializers.serialize(object.minActivationHeight,
          specifiedType: const FullType(int)));
    if (object.statistics != null) {
      result
        ..add(r'statistics')
        ..add(serializers.serialize(object.statistics,
            specifiedType: const FullType(Statistics)));
    }
    if (object.height != null) {
      result
        ..add(r'height')
        ..add(serializers.serialize(object.height,
            specifiedType: const FullType(int)));
    }
    if (object.active != null) {
      result
        ..add(r'active')
        ..add(serializers.serialize(object.active,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  Bip9Data deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = Bip9DataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.status = valueDes;
          break;
        case r'bit':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.bit = valueDes;
          break;
        case r'start_time':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.startTime = valueDes;
          break;
        case r'timeout':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.timeout = valueDes;
          break;
        case r'since':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.since = valueDes;
          break;
        case r'min_activation_height':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.minActivationHeight = valueDes;
          break;
        case r'statistics':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(Statistics)) as Statistics;
          result.statistics.replace(valueDes);
          break;
        case r'height':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.height = valueDes;
          break;
        case r'active':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.active = valueDes;
          break;
      }
    }
    return result.build();
  }
}
