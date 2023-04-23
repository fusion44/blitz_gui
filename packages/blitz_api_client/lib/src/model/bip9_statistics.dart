//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bip9_statistics.g.dart';

/// Bip9Statistics
///
/// Properties:
/// * [period] - The length in blocks of the BIP9 signalling period
/// * [threshold] - The number of blocks with the version bit set required to activate the feature
/// * [elapsed] - The number of blocks elapsed since the beginning of the current period
/// * [count] - The number of blocks with the version bit set in the current period
/// * [possible] - False if there are not enough blocks left in this period to pass activation threshold
abstract class Bip9Statistics
    implements Built<Bip9Statistics, Bip9StatisticsBuilder> {
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

  Bip9Statistics._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Bip9StatisticsBuilder b) => b;

  factory Bip9Statistics([void updates(Bip9StatisticsBuilder b)]) =
      _$Bip9Statistics;

  @BuiltValueSerializer(custom: true)
  static Serializer<Bip9Statistics> get serializer =>
      _$Bip9StatisticsSerializer();
}

class _$Bip9StatisticsSerializer
    implements StructuredSerializer<Bip9Statistics> {
  @override
  final Iterable<Type> types = const [Bip9Statistics, _$Bip9Statistics];

  @override
  final String wireName = r'Bip9Statistics';

  @override
  Iterable<Object?> serialize(Serializers serializers, Bip9Statistics object,
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
  Bip9Statistics deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = Bip9StatisticsBuilder();

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
