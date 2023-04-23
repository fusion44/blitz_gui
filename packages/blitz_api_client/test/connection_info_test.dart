import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for ConnectionInfo
void main() {
  final instance = ConnectionInfoBuilder();
  // TODO add properties to the builder and call build()

  group(ConnectionInfo, () {
    // lnd macaroon with admin rights in hexstring format
    // String lndAdminMacaroon (default value: '')
    test('to test the property `lndAdminMacaroon`', () async {
      // TODO
    });

    // lnd macaroon that only creates invoices in hexstring format
    // String lndInvoiceMacaroon (default value: '')
    test('to test the property `lndInvoiceMacaroon`', () async {
      // TODO
    });

    // lnd macaroon with only read-only rights in hexstring format
    // String lndReadonlyMacaroon (default value: '')
    test('to test the property `lndReadonlyMacaroon`', () async {
      // TODO
    });

    // lnd tls cert in hexstring format
    // String lndTlsCert (default value: '')
    test('to test the property `lndTlsCert`', () async {
      // TODO
    });

    // lnd rest api onion address
    // String lndRestOnion (default value: '')
    test('to test the property `lndRestOnion`', () async {
      // TODO
    });

    // connect BtcPay server locally to your lnd lightning node
    // String lndBtcpayConnectionString (default value: '')
    test('to test the property `lndBtcpayConnectionString`', () async {
      // TODO
    });

    // connect Zeus app to your lnd lightning node
    // String lndZeusConnectionString (default value: '')
    test('to test the property `lndZeusConnectionString`', () async {
      // TODO
    });

    // connect Zeus app to your core lightning node over rest
    // String clRestZeusConnectionString (default value: '')
    test('to test the property `clRestZeusConnectionString`', () async {
      // TODO
    });

    // core lightning rest macaroon
    // String clRestMacaroon (default value: '')
    test('to test the property `clRestMacaroon`', () async {
      // TODO
    });

    // core lightning rest onion address
    // String clRestOnion (default value: '')
    test('to test the property `clRestOnion`', () async {
      // TODO
    });
  });
}
