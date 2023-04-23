//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/features_entry.dart';
import 'package:blitz_api_client/src/model/route_hint.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payment_request.g.dart';

/// PaymentRequest
///
/// Properties:
/// * [destination]
/// * [paymentHash]
/// * [numSatoshis] - Deprecated. User num_msat instead
/// * [timestamp]
/// * [expiry]
/// * [description]
/// * [descriptionHash]
/// * [fallbackAddr]
/// * [cltvExpiry]
/// * [routeHints] - A list of [HopHint] for the RouteHint
/// * [paymentAddr] - The payment address in hex format
/// * [numMsat]
/// * [features]
/// * [currency] - Optional requested currency of the payment.
abstract class PaymentRequest
    implements Built<PaymentRequest, PaymentRequestBuilder> {
  @BuiltValueField(wireName: r'destination')
  String get destination;

  @BuiltValueField(wireName: r'payment_hash')
  String get paymentHash;

  /// Deprecated. User num_msat instead
  @BuiltValueField(wireName: r'num_satoshis')
  int? get numSatoshis;

  @BuiltValueField(wireName: r'timestamp')
  int get timestamp;

  @BuiltValueField(wireName: r'expiry')
  int get expiry;

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'description_hash')
  String? get descriptionHash;

  @BuiltValueField(wireName: r'fallback_addr')
  String? get fallbackAddr;

  @BuiltValueField(wireName: r'cltv_expiry')
  int get cltvExpiry;

  /// A list of [HopHint] for the RouteHint
  @BuiltValueField(wireName: r'route_hints')
  BuiltList<RouteHint>? get routeHints;

  /// The payment address in hex format
  @BuiltValueField(wireName: r'payment_addr')
  String? get paymentAddr;

  @BuiltValueField(wireName: r'num_msat')
  int? get numMsat;

  @BuiltValueField(wireName: r'features')
  BuiltList<FeaturesEntry>? get features;

  /// Optional requested currency of the payment.
  @BuiltValueField(wireName: r'currency')
  String? get currency;

  PaymentRequest._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaymentRequestBuilder b) => b
    ..routeHints = ListBuilder()
    ..paymentAddr = ''
    ..features = ListBuilder()
    ..currency = '';

  factory PaymentRequest([void updates(PaymentRequestBuilder b)]) =
      _$PaymentRequest;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaymentRequest> get serializer =>
      _$PaymentRequestSerializer();
}

class _$PaymentRequestSerializer
    implements StructuredSerializer<PaymentRequest> {
  @override
  final Iterable<Type> types = const [PaymentRequest, _$PaymentRequest];

  @override
  final String wireName = r'PaymentRequest';

  @override
  Iterable<Object?> serialize(Serializers serializers, PaymentRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'destination')
      ..add(serializers.serialize(object.destination,
          specifiedType: const FullType(String)));
    result
      ..add(r'payment_hash')
      ..add(serializers.serialize(object.paymentHash,
          specifiedType: const FullType(String)));
    if (object.numSatoshis != null) {
      result
        ..add(r'num_satoshis')
        ..add(serializers.serialize(object.numSatoshis,
            specifiedType: const FullType(int)));
    }
    result
      ..add(r'timestamp')
      ..add(serializers.serialize(object.timestamp,
          specifiedType: const FullType(int)));
    result
      ..add(r'expiry')
      ..add(serializers.serialize(object.expiry,
          specifiedType: const FullType(int)));
    result
      ..add(r'description')
      ..add(serializers.serialize(object.description,
          specifiedType: const FullType(String)));
    if (object.descriptionHash != null) {
      result
        ..add(r'description_hash')
        ..add(serializers.serialize(object.descriptionHash,
            specifiedType: const FullType(String)));
    }
    if (object.fallbackAddr != null) {
      result
        ..add(r'fallback_addr')
        ..add(serializers.serialize(object.fallbackAddr,
            specifiedType: const FullType(String)));
    }
    result
      ..add(r'cltv_expiry')
      ..add(serializers.serialize(object.cltvExpiry,
          specifiedType: const FullType(int)));
    if (object.routeHints != null) {
      result
        ..add(r'route_hints')
        ..add(serializers.serialize(object.routeHints,
            specifiedType: const FullType(BuiltList, [FullType(RouteHint)])));
    }
    if (object.paymentAddr != null) {
      result
        ..add(r'payment_addr')
        ..add(serializers.serialize(object.paymentAddr,
            specifiedType: const FullType(String)));
    }
    if (object.numMsat != null) {
      result
        ..add(r'num_msat')
        ..add(serializers.serialize(object.numMsat,
            specifiedType: const FullType(int)));
    }
    if (object.features != null) {
      result
        ..add(r'features')
        ..add(serializers.serialize(object.features,
            specifiedType:
                const FullType(BuiltList, [FullType(FeaturesEntry)])));
    }
    if (object.currency != null) {
      result
        ..add(r'currency')
        ..add(serializers.serialize(object.currency,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  PaymentRequest deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = PaymentRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'destination':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.destination = valueDes;
          break;
        case r'payment_hash':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.paymentHash = valueDes;
          break;
        case r'num_satoshis':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.numSatoshis = valueDes;
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.timestamp = valueDes;
          break;
        case r'expiry':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.expiry = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.description = valueDes;
          break;
        case r'description_hash':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.descriptionHash = valueDes;
          break;
        case r'fallback_addr':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.fallbackAddr = valueDes;
          break;
        case r'cltv_expiry':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.cltvExpiry = valueDes;
          break;
        case r'route_hints':
          final valueDes = serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, [FullType(RouteHint)]))
              as BuiltList<RouteHint>;
          result.routeHints.replace(valueDes);
          break;
        case r'payment_addr':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.paymentAddr = valueDes;
          break;
        case r'num_msat':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.numMsat = valueDes;
          break;
        case r'features':
          final valueDes = serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, [FullType(FeaturesEntry)]))
              as BuiltList<FeaturesEntry>;
          result.features.replace(valueDes);
          break;
        case r'currency':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.currency = valueDes;
          break;
      }
    }
    return result.build();
  }
}
