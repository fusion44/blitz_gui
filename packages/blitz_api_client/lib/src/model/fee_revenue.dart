//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'fee_revenue.g.dart';

/// FeeRevenue
///
/// Properties:
/// * [day] - Fee revenue earned in the last 24 hours
/// * [week] - Fee revenue earned in the last 7days
/// * [month] - Fee revenue earned in the last month
/// * [year] - Fee revenue earned in the last year. Might be null if not implemented by backend.
/// * [total] - Fee revenue earned in the last year. Might be null if not implemented by backend
abstract class FeeRevenue implements Built<FeeRevenue, FeeRevenueBuilder> {
  /// Fee revenue earned in the last 24 hours
  @BuiltValueField(wireName: r'day')
  int get day;

  /// Fee revenue earned in the last 7days
  @BuiltValueField(wireName: r'week')
  int get week;

  /// Fee revenue earned in the last month
  @BuiltValueField(wireName: r'month')
  int get month;

  /// Fee revenue earned in the last year. Might be null if not implemented by backend.
  @BuiltValueField(wireName: r'year')
  int? get year;

  /// Fee revenue earned in the last year. Might be null if not implemented by backend
  @BuiltValueField(wireName: r'total')
  int? get total;

  FeeRevenue._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FeeRevenueBuilder b) => b;

  factory FeeRevenue([void updates(FeeRevenueBuilder b)]) = _$FeeRevenue;

  @BuiltValueSerializer(custom: true)
  static Serializer<FeeRevenue> get serializer => _$FeeRevenueSerializer();
}

class _$FeeRevenueSerializer implements StructuredSerializer<FeeRevenue> {
  @override
  final Iterable<Type> types = const [FeeRevenue, _$FeeRevenue];

  @override
  final String wireName = r'FeeRevenue';

  @override
  Iterable<Object?> serialize(Serializers serializers, FeeRevenue object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'day')
      ..add(serializers.serialize(object.day,
          specifiedType: const FullType(int)));
    result
      ..add(r'week')
      ..add(serializers.serialize(object.week,
          specifiedType: const FullType(int)));
    result
      ..add(r'month')
      ..add(serializers.serialize(object.month,
          specifiedType: const FullType(int)));
    if (object.year != null) {
      result
        ..add(r'year')
        ..add(serializers.serialize(object.year,
            specifiedType: const FullType(int)));
    }
    if (object.total != null) {
      result
        ..add(r'total')
        ..add(serializers.serialize(object.total,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  FeeRevenue deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = FeeRevenueBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'day':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.day = valueDes;
          break;
        case r'week':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.week = valueDes;
          break;
        case r'month':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.month = valueDes;
          break;
        case r'year':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.year = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.total = valueDes;
          break;
      }
    }
    return result.build();
  }
}
