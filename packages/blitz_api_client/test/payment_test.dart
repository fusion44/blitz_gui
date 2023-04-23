import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for Payment
void main() {
  final instance = PaymentBuilder();
  // TODO add properties to the builder and call build()

  group(Payment, () {
    // The payment hash
    // String paymentHash
    test('to test the property `paymentHash`', () async {
      // TODO
    });

    // The payment preimage
    // String paymentPreimage
    test('to test the property `paymentPreimage`', () async {
      // TODO
    });

    // The value of the payment in milli-satoshis
    // int valueMsat
    test('to test the property `valueMsat`', () async {
      // TODO
    });

    // The optional payment request being fulfilled.
    // String paymentRequest
    test('to test the property `paymentRequest`', () async {
      // TODO
    });

    // The status of the payment.
    // PaymentStatus status
    test('to test the property `status`', () async {
      // TODO
    });

    // The fee paid for this payment in msat
    // int feeMsat
    test('to test the property `feeMsat`', () async {
      // TODO
    });

    // The time in UNIX nanoseconds at which the payment was created.
    // int creationTimeNs
    test('to test the property `creationTimeNs`', () async {
      // TODO
    });

    // The HTLCs made in attempt to settle the payment.
    // BuiltList<HTLCAttempt> htlcs (default value: ListBuilder())
    test('to test the property `htlcs`', () async {
      // TODO
    });

    // The payment index. Only set with LND, 0 otherwise.
    // int paymentIndex (default value: 0)
    test('to test the property `paymentIndex`', () async {
      // TODO
    });

    // The payment label. Only set with CLN, empty otherwise.
    // String label (default value: '')
    test('to test the property `label`', () async {
      // TODO
    });

    // The failure reason
    // PaymentFailureReason failureReason
    test('to test the property `failureReason`', () async {
      // TODO
    });
  });
}
