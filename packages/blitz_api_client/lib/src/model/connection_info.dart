//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'connection_info.g.dart';

/// ConnectionInfo
///
/// Properties:
/// * [lndAdminMacaroon] - lnd macaroon with admin rights in hexstring format
/// * [lndInvoiceMacaroon] - lnd macaroon that only creates invoices in hexstring format
/// * [lndReadonlyMacaroon] - lnd macaroon with only read-only rights in hexstring format
/// * [lndTlsCert] - lnd tls cert in hexstring format
/// * [lndRestOnion] - lnd rest api onion address
/// * [lndBtcpayConnectionString] - connect BtcPay server locally to your lnd lightning node
/// * [lndZeusConnectionString] - connect Zeus app to your lnd lightning node
/// * [clRestZeusConnectionString] - connect Zeus app to your core lightning node over rest
/// * [clRestMacaroon] - core lightning rest macaroon
/// * [clRestOnion] - core lightning rest onion address
abstract class ConnectionInfo
    implements Built<ConnectionInfo, ConnectionInfoBuilder> {
  /// lnd macaroon with admin rights in hexstring format
  @BuiltValueField(wireName: r'lnd_admin_macaroon')
  String? get lndAdminMacaroon;

  /// lnd macaroon that only creates invoices in hexstring format
  @BuiltValueField(wireName: r'lnd_invoice_macaroon')
  String? get lndInvoiceMacaroon;

  /// lnd macaroon with only read-only rights in hexstring format
  @BuiltValueField(wireName: r'lnd_readonly_macaroon')
  String? get lndReadonlyMacaroon;

  /// lnd tls cert in hexstring format
  @BuiltValueField(wireName: r'lnd_tls_cert')
  String? get lndTlsCert;

  /// lnd rest api onion address
  @BuiltValueField(wireName: r'lnd_rest_onion')
  String? get lndRestOnion;

  /// connect BtcPay server locally to your lnd lightning node
  @BuiltValueField(wireName: r'lnd_btcpay_connection_string')
  String? get lndBtcpayConnectionString;

  /// connect Zeus app to your lnd lightning node
  @BuiltValueField(wireName: r'lnd_zeus_connection_string')
  String? get lndZeusConnectionString;

  /// connect Zeus app to your core lightning node over rest
  @BuiltValueField(wireName: r'cl_rest_zeus_connection_string')
  String? get clRestZeusConnectionString;

  /// core lightning rest macaroon
  @BuiltValueField(wireName: r'cl_rest_macaroon')
  String? get clRestMacaroon;

  /// core lightning rest onion address
  @BuiltValueField(wireName: r'cl_rest_onion')
  String? get clRestOnion;

  ConnectionInfo._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConnectionInfoBuilder b) => b
    ..lndAdminMacaroon = ''
    ..lndInvoiceMacaroon = ''
    ..lndReadonlyMacaroon = ''
    ..lndTlsCert = ''
    ..lndRestOnion = ''
    ..lndBtcpayConnectionString = ''
    ..lndZeusConnectionString = ''
    ..clRestZeusConnectionString = ''
    ..clRestMacaroon = ''
    ..clRestOnion = '';

  factory ConnectionInfo([void updates(ConnectionInfoBuilder b)]) =
      _$ConnectionInfo;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConnectionInfo> get serializer =>
      _$ConnectionInfoSerializer();
}

class _$ConnectionInfoSerializer
    implements StructuredSerializer<ConnectionInfo> {
  @override
  final Iterable<Type> types = const [ConnectionInfo, _$ConnectionInfo];

  @override
  final String wireName = r'ConnectionInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, ConnectionInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    if (object.lndAdminMacaroon != null) {
      result
        ..add(r'lnd_admin_macaroon')
        ..add(serializers.serialize(object.lndAdminMacaroon,
            specifiedType: const FullType(String)));
    }
    if (object.lndInvoiceMacaroon != null) {
      result
        ..add(r'lnd_invoice_macaroon')
        ..add(serializers.serialize(object.lndInvoiceMacaroon,
            specifiedType: const FullType(String)));
    }
    if (object.lndReadonlyMacaroon != null) {
      result
        ..add(r'lnd_readonly_macaroon')
        ..add(serializers.serialize(object.lndReadonlyMacaroon,
            specifiedType: const FullType(String)));
    }
    if (object.lndTlsCert != null) {
      result
        ..add(r'lnd_tls_cert')
        ..add(serializers.serialize(object.lndTlsCert,
            specifiedType: const FullType(String)));
    }
    if (object.lndRestOnion != null) {
      result
        ..add(r'lnd_rest_onion')
        ..add(serializers.serialize(object.lndRestOnion,
            specifiedType: const FullType(String)));
    }
    if (object.lndBtcpayConnectionString != null) {
      result
        ..add(r'lnd_btcpay_connection_string')
        ..add(serializers.serialize(object.lndBtcpayConnectionString,
            specifiedType: const FullType(String)));
    }
    if (object.lndZeusConnectionString != null) {
      result
        ..add(r'lnd_zeus_connection_string')
        ..add(serializers.serialize(object.lndZeusConnectionString,
            specifiedType: const FullType(String)));
    }
    if (object.clRestZeusConnectionString != null) {
      result
        ..add(r'cl_rest_zeus_connection_string')
        ..add(serializers.serialize(object.clRestZeusConnectionString,
            specifiedType: const FullType(String)));
    }
    if (object.clRestMacaroon != null) {
      result
        ..add(r'cl_rest_macaroon')
        ..add(serializers.serialize(object.clRestMacaroon,
            specifiedType: const FullType(String)));
    }
    if (object.clRestOnion != null) {
      result
        ..add(r'cl_rest_onion')
        ..add(serializers.serialize(object.clRestOnion,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ConnectionInfo deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = ConnectionInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'lnd_admin_macaroon':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.lndAdminMacaroon = valueDes;
          break;
        case r'lnd_invoice_macaroon':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.lndInvoiceMacaroon = valueDes;
          break;
        case r'lnd_readonly_macaroon':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.lndReadonlyMacaroon = valueDes;
          break;
        case r'lnd_tls_cert':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.lndTlsCert = valueDes;
          break;
        case r'lnd_rest_onion':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.lndRestOnion = valueDes;
          break;
        case r'lnd_btcpay_connection_string':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.lndBtcpayConnectionString = valueDes;
          break;
        case r'lnd_zeus_connection_string':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.lndZeusConnectionString = valueDes;
          break;
        case r'cl_rest_zeus_connection_string':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.clRestZeusConnectionString = valueDes;
          break;
        case r'cl_rest_macaroon':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.clRestMacaroon = valueDes;
          break;
        case r'cl_rest_onion':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.clRestOnion = valueDes;
          break;
      }
    }
    return result.build();
  }
}
