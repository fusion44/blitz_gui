//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/amp1.dart';
import 'package:blitz_api_client/src/model/custom_records_entry.dart';
import 'package:blitz_api_client/src/model/invoice_htlc_state.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'invoice_htlc.g.dart';

/// InvoiceHTLC
///
/// Properties:
/// * [chanId] - The channel ID over which the HTLC was received.
/// * [htlcIndex] - The index of the HTLC on the channel.
/// * [amtMsat] - The amount of the HTLC in msat.
/// * [acceptHeight] - The block height at which this HTLC was accepted.
/// * [acceptTime] - The time at which this HTLC was accepted.
/// * [resolveTime] - The time at which this HTLC was resolved.
/// * [expiryHeight] - The block height at which this HTLC expires.
/// * [state] - The state of the HTLC.
/// * [customRecords] - Custom tlv records.
/// * [mppTotalAmtMsat] - The total amount of the mpp payment in msat.
/// * [amp]
abstract class InvoiceHTLC implements Built<InvoiceHTLC, InvoiceHTLCBuilder> {
  /// The channel ID over which the HTLC was received.
  @BuiltValueField(wireName: r'chan_id')
  int get chanId;

  /// The index of the HTLC on the channel.
  @BuiltValueField(wireName: r'htlc_index')
  int get htlcIndex;

  /// The amount of the HTLC in msat.
  @BuiltValueField(wireName: r'amt_msat')
  int get amtMsat;

  /// The block height at which this HTLC was accepted.
  @BuiltValueField(wireName: r'accept_height')
  int get acceptHeight;

  /// The time at which this HTLC was accepted.
  @BuiltValueField(wireName: r'accept_time')
  int get acceptTime;

  /// The time at which this HTLC was resolved.
  @BuiltValueField(wireName: r'resolve_time')
  int get resolveTime;

  /// The block height at which this HTLC expires.
  @BuiltValueField(wireName: r'expiry_height')
  int get expiryHeight;

  /// The state of the HTLC.
  @BuiltValueField(wireName: r'state')
  InvoiceHTLCState? get state;

  /// Custom tlv records.
  @BuiltValueField(wireName: r'custom_records')
  BuiltList<CustomRecordsEntry>? get customRecords;

  /// The total amount of the mpp payment in msat.
  @BuiltValueField(wireName: r'mpp_total_amt_msat')
  int get mppTotalAmtMsat;

  @BuiltValueField(wireName: r'amp')
  Amp1? get amp;

  InvoiceHTLC._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InvoiceHTLCBuilder b) =>
      b..customRecords = ListBuilder();

  factory InvoiceHTLC([void updates(InvoiceHTLCBuilder b)]) = _$InvoiceHTLC;

  @BuiltValueSerializer(custom: true)
  static Serializer<InvoiceHTLC> get serializer => _$InvoiceHTLCSerializer();
}

class _$InvoiceHTLCSerializer implements StructuredSerializer<InvoiceHTLC> {
  @override
  final Iterable<Type> types = const [InvoiceHTLC, _$InvoiceHTLC];

  @override
  final String wireName = r'InvoiceHTLC';

  @override
  Iterable<Object?> serialize(Serializers serializers, InvoiceHTLC object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'chan_id')
      ..add(serializers.serialize(object.chanId,
          specifiedType: const FullType(int)));
    result
      ..add(r'htlc_index')
      ..add(serializers.serialize(object.htlcIndex,
          specifiedType: const FullType(int)));
    result
      ..add(r'amt_msat')
      ..add(serializers.serialize(object.amtMsat,
          specifiedType: const FullType(int)));
    result
      ..add(r'accept_height')
      ..add(serializers.serialize(object.acceptHeight,
          specifiedType: const FullType(int)));
    result
      ..add(r'accept_time')
      ..add(serializers.serialize(object.acceptTime,
          specifiedType: const FullType(int)));
    result
      ..add(r'resolve_time')
      ..add(serializers.serialize(object.resolveTime,
          specifiedType: const FullType(int)));
    result
      ..add(r'expiry_height')
      ..add(serializers.serialize(object.expiryHeight,
          specifiedType: const FullType(int)));
    result
      ..add(r'state')
      ..add(object.state == null
          ? null
          : serializers.serialize(object.state,
              specifiedType: const FullType.nullable(InvoiceHTLCState)));
    if (object.customRecords != null) {
      result
        ..add(r'custom_records')
        ..add(serializers.serialize(object.customRecords,
            specifiedType:
                const FullType(BuiltList, [FullType(CustomRecordsEntry)])));
    }
    result
      ..add(r'mpp_total_amt_msat')
      ..add(serializers.serialize(object.mppTotalAmtMsat,
          specifiedType: const FullType(int)));
    if (object.amp != null) {
      result
        ..add(r'amp')
        ..add(serializers.serialize(object.amp,
            specifiedType: const FullType(Amp1)));
    }
    return result;
  }

  @override
  InvoiceHTLC deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = InvoiceHTLCBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'chan_id':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.chanId = valueDes;
          break;
        case r'htlc_index':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.htlcIndex = valueDes;
          break;
        case r'amt_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.amtMsat = valueDes;
          break;
        case r'accept_height':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.acceptHeight = valueDes;
          break;
        case r'accept_time':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.acceptTime = valueDes;
          break;
        case r'resolve_time':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.resolveTime = valueDes;
          break;
        case r'expiry_height':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.expiryHeight = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType.nullable(InvoiceHTLCState))
              as InvoiceHTLCState?;
          if (valueDes == null) continue;
          result.state = valueDes;
          break;
        case r'custom_records':
          final valueDes = serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, [FullType(CustomRecordsEntry)]))
              as BuiltList<CustomRecordsEntry>;
          result.customRecords.replace(valueDes);
          break;
        case r'mpp_total_amt_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.mppTotalAmtMsat = valueDes;
          break;
        case r'amp':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(Amp1)) as Amp1;
          result.amp.replace(valueDes);
          break;
      }
    }
    return result.build();
  }
}
