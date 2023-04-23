//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mpp_record.g.dart';

/// MPPRecord
///
/// Properties:
/// * [paymentAddr]
/// * [totalAmtMsat]
abstract class MPPRecord implements Built<MPPRecord, MPPRecordBuilder> {
  @BuiltValueField(wireName: r'payment_addr')
  String get paymentAddr;

  @BuiltValueField(wireName: r'total_amt_msat')
  int get totalAmtMsat;

  MPPRecord._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MPPRecordBuilder b) => b;

  factory MPPRecord([void updates(MPPRecordBuilder b)]) = _$MPPRecord;

  @BuiltValueSerializer(custom: true)
  static Serializer<MPPRecord> get serializer => _$MPPRecordSerializer();
}

class _$MPPRecordSerializer implements StructuredSerializer<MPPRecord> {
  @override
  final Iterable<Type> types = const [MPPRecord, _$MPPRecord];

  @override
  final String wireName = r'MPPRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, MPPRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'payment_addr')
      ..add(serializers.serialize(object.paymentAddr,
          specifiedType: const FullType(String)));
    result
      ..add(r'total_amt_msat')
      ..add(serializers.serialize(object.totalAmtMsat,
          specifiedType: const FullType(int)));
    return result;
  }

  @override
  MPPRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = MPPRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'payment_addr':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.paymentAddr = valueDes;
          break;
        case r'total_amt_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.totalAmtMsat = valueDes;
          break;
      }
    }
    return result.build();
  }
}
