//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/bip9_statistics.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'statistics.g.dart';

/// numeric statistics about BIP9 signalling for a softfork(only for `started` status)
///
/// Properties:
/// * [period] - The length in blocks of the BIP9 signalling period
/// * [threshold] - The number of blocks with the version bit set required to activate the feature
/// * [elapsed] - The number of blocks elapsed since the beginning of the current period
/// * [count] - The number of blocks with the version bit set in the current period
/// * [possible] - False if there are not enough blocks left in this period to pass activation threshold
abstract class Statistics implements Built<Statistics, StatisticsBuilder> {
  /// The length in blocks of the BIP9 signalling period
  @BuiltValueField(wireName: r'period')
  int get period;

  /// The number of blocks with the version bit set required to activate the feature
  @BuiltValueField(wireName: r'threshold')
  int get threshold;

  /// The number of blocks elapsed since the beginning of the current period
  @BuiltValueField(wireName: r'elapsed')
  int get elapsed;

  /// The number of blocks with the version bit set in the current period
  @BuiltValueField(wireName: r'count')
  int get count;

  /// False if there are not enough blocks left in this period to pass activation threshold
  @BuiltValueField(wireName: r'possible')
  bool get possible;

  Statistics._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StatisticsBuilder b) => b;

  factory Statistics([void updates(StatisticsBuilder b)]) = _$Statistics;

  @BuiltValueSerializer(custom: true)
  static Serializer<Statistics> get serializer => _$StatisticsSerializer();
}

class _$StatisticsSerializer implements StructuredSerializer<Statistics> {
  @override
  final Iterable<Type> types = const [Statistics, _$Statistics];

  @override
  final String wireName = r'Statistics';

  @override
  Iterable<Object?> serialize(Serializers serializers, Statistics object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'period')
      ..add(serializers.serialize(object.period,
          specifiedType: const FullType(int)));
    result
      ..add(r'threshold')
      ..add(serializers.serialize(object.threshold,
          specifiedType: const FullType(int)));
    result
      ..add(r'elapsed')
      ..add(serializers.serialize(object.elapsed,
          specifiedType: const FullType(int)));
    result
      ..add(r'count')
      ..add(serializers.serialize(object.count,
          specifiedType: const FullType(int)));
    result
      ..add(r'possible')
      ..add(serializers.serialize(object.possible,
          specifiedType: const FullType(bool)));
    return result;
  }

  @override
  Statistics deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = StatisticsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'period':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.period = valueDes;
          break;
        case r'threshold':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.threshold = valueDes;
          break;
        case r'elapsed':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.elapsed = valueDes;
          break;
        case r'count':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.count = valueDes;
          break;
        case r'possible':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          result.possible = valueDes;
          break;
      }
    }
    return result.build();
  }
}
