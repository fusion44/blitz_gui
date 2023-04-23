//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/amp_record.dart';
import 'package:blitz_api_client/src/model/custom_records_entry.dart';
import 'package:blitz_api_client/src/model/hop.dart';
import 'package:blitz_api_client/src/model/mpp_record.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'route.g.dart';

/// Route
///
/// Properties:
/// * [totalTimeLock]
/// * [totalFees]
/// * [totalAmt]
/// * [hops]
/// * [totalFeesMsat]
/// * [totalAmtMsat]
/// * [mppRecord]
/// * [ampRecord]
/// * [customRecords]
abstract class Route implements Built<Route, RouteBuilder> {
  @BuiltValueField(wireName: r'total_time_lock')
  int get totalTimeLock;

  @BuiltValueField(wireName: r'total_fees')
  int get totalFees;

  @BuiltValueField(wireName: r'total_amt')
  int get totalAmt;

  @BuiltValueField(wireName: r'hops')
  BuiltList<Hop> get hops;

  @BuiltValueField(wireName: r'total_fees_msat')
  int get totalFeesMsat;

  @BuiltValueField(wireName: r'total_amt_msat')
  int get totalAmtMsat;

  @BuiltValueField(wireName: r'mpp_record')
  MPPRecord? get mppRecord;

  @BuiltValueField(wireName: r'amp_record')
  AMPRecord? get ampRecord;

  @BuiltValueField(wireName: r'custom_records')
  BuiltList<CustomRecordsEntry> get customRecords;

  Route._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RouteBuilder b) => b;

  factory Route([void updates(RouteBuilder b)]) = _$Route;

  @BuiltValueSerializer(custom: true)
  static Serializer<Route> get serializer => _$RouteSerializer();
}

class _$RouteSerializer implements StructuredSerializer<Route> {
  @override
  final Iterable<Type> types = const [Route, _$Route];

  @override
  final String wireName = r'Route';

  @override
  Iterable<Object?> serialize(Serializers serializers, Route object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'total_time_lock')
      ..add(serializers.serialize(object.totalTimeLock,
          specifiedType: const FullType(int)));
    result
      ..add(r'total_fees')
      ..add(serializers.serialize(object.totalFees,
          specifiedType: const FullType(int)));
    result
      ..add(r'total_amt')
      ..add(serializers.serialize(object.totalAmt,
          specifiedType: const FullType(int)));
    result
      ..add(r'hops')
      ..add(serializers.serialize(object.hops,
          specifiedType: const FullType(BuiltList, [FullType(Hop)])));
    result
      ..add(r'total_fees_msat')
      ..add(serializers.serialize(object.totalFeesMsat,
          specifiedType: const FullType(int)));
    result
      ..add(r'total_amt_msat')
      ..add(serializers.serialize(object.totalAmtMsat,
          specifiedType: const FullType(int)));
    if (object.mppRecord != null) {
      result
        ..add(r'mpp_record')
        ..add(serializers.serialize(object.mppRecord,
            specifiedType: const FullType(MPPRecord)));
    }
    if (object.ampRecord != null) {
      result
        ..add(r'amp_record')
        ..add(serializers.serialize(object.ampRecord,
            specifiedType: const FullType(AMPRecord)));
    }
    result
      ..add(r'custom_records')
      ..add(serializers.serialize(object.customRecords,
          specifiedType:
              const FullType(BuiltList, [FullType(CustomRecordsEntry)])));
    return result;
  }

  @override
  Route deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = RouteBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'total_time_lock':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.totalTimeLock = valueDes;
          break;
        case r'total_fees':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.totalFees = valueDes;
          break;
        case r'total_amt':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.totalAmt = valueDes;
          break;
        case r'hops':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType(BuiltList, [FullType(Hop)]))
              as BuiltList<Hop>;
          result.hops.replace(valueDes);
          break;
        case r'total_fees_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.totalFeesMsat = valueDes;
          break;
        case r'total_amt_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.totalAmtMsat = valueDes;
          break;
        case r'mpp_record':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(MPPRecord)) as MPPRecord;
          result.mppRecord.replace(valueDes);
          break;
        case r'amp_record':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(AMPRecord)) as AMPRecord;
          result.ampRecord.replace(valueDes);
          break;
        case r'custom_records':
          final valueDes = serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, [FullType(CustomRecordsEntry)]))
              as BuiltList<CustomRecordsEntry>;
          result.customRecords.replace(valueDes);
          break;
      }
    }
    return result.build();
  }
}
