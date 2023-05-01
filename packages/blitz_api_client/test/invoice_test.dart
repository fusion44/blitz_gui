import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for Invoice
void main() {
  final instance = InvoiceBuilder();
  // TODO add properties to the builder and call build()

  group(Invoice, () {
    // Optional memo to attach along with the invoice. Used for record keeping purposes for the invoice's creator,         and will also be set in the description field of the encoded payment request if the description_hash field is not being used.
    // String memo
    test('to test the property `memo`', () async {
      // TODO
    });

    // The hex-encoded preimage(32 byte) which will allow settling an incoming HTLC payable to this preimage.
    // String rPreimage
    test('to test the property `rPreimage`', () async {
      // TODO
    });

    // The hash of the preimage.
    // String rHash
    test('to test the property `rHash`', () async {
      // TODO
    });

    // The value of this invoice in milli satoshis.
    // int valueMsat
    test('to test the property `valueMsat`', () async {
      // TODO
    });

    // Whether this invoice has been fulfilled
    // bool settled (default value: false)
    test('to test the property `settled`', () async {
      // TODO
    });

    // When this invoice was created. Not available with CLN.
    // int creationDate
    test('to test the property `creationDate`', () async {
      // TODO
    });

    // When this invoice was settled. Not available with pending invoices.
    // int settleDate
    test('to test the property `settleDate`', () async {
      // TODO
    });

    // The time at which this invoice expires
    // int expiryDate
    test('to test the property `expiryDate`', () async {
      // TODO
    });

    // A bare-bones invoice for a payment within the     Lightning Network. With the details of the invoice, the sender has all the data necessary to     send a payment to the recipient.
    // String paymentRequest
    test('to test the property `paymentRequest`', () async {
      // TODO
    });

    //      Hash(SHA-256) of a description of the payment. Used if the description of payment(memo) is too     long to naturally fit within the description field of an encoded payment request.
    // String descriptionHash
    test('to test the property `descriptionHash`', () async {
      // TODO
    });

    // Payment request expiry time in seconds. Default is 3600 (1 hour).
    // int expiry
    test('to test the property `expiry`', () async {
      // TODO
    });

    // Fallback on-chain address.
    // String fallbackAddr
    test('to test the property `fallbackAddr`', () async {
      // TODO
    });

    // Delta to use for the time-lock of the CLTV extended to the final hop.
    // int cltvExpiry
    test('to test the property `cltvExpiry`', () async {
      // TODO
    });

    //      Route hints that can each be individually used to assist in reaching the invoice's destination.
    // BuiltList<RouteHint> routeHints
    test('to test the property `routeHints`', () async {
      // TODO
    });

    // Whether this invoice should include routing hints for private channels.
    // bool private
    test('to test the property `private`', () async {
      // TODO
    });

    //  The index of this invoice. Each newly created invoice will increment this index making it monotonically increasing. CLN and LND handle ids differently. LND will generate an auto incremented integer id, while CLN will use a user supplied string id. To unify both, we auto generate an id for CLN and use the add_index for LND.  For `LND` this will be an `integer` in string form. This is auto generated by LND.  For `CLN` this will be a `string`. If the invoice was generated by BlitzAPI, this will be a [Firebase-like PushID](https://firebase.blog/posts/2015/02/the-2120-ways-to-ensure-unique_68). If generated by some other method, it'll be the string supplied by the user at the time of creation of the invoice.
    // String addIndex
    test('to test the property `addIndex`', () async {
      // TODO
    });

    //          The \"settle\" index of this invoice. Each newly settled invoice will  increment this index making it monotonically increasing.
    // int settleIndex
    test('to test the property `settleIndex`', () async {
      // TODO
    });

    //      The amount that was accepted for this invoice, in satoshis. This     will ONLY be set if this invoice has been settled. We provide     this field as if the invoice was created with a zero value,     then we need to record what amount was ultimately accepted.     Additionally, it's possible that the sender paid MORE that     was specified in the original invoice. So we'll record that here as well.
    // int amtPaidSat
    test('to test the property `amtPaidSat`', () async {
      // TODO
    });

    //      The amount that was accepted for this invoice, in millisatoshis.     This will ONLY be set if this invoice has been settled. We     provide this field as if the invoice was created with a zero value,     then we need to record what amount was ultimately accepted. Additionally,     it's possible that the sender paid MORE that was specified in the     original invoice. So we'll record that here as well.
    // int amtPaidMsat
    test('to test the property `amtPaidMsat`', () async {
      // TODO
    });

    // The state the invoice is in.
    // InvoiceState state
    test('to test the property `state`', () async {
      // TODO
    });

    // List of HTLCs paying to this invoice[EXPERIMENTAL].
    // BuiltList<InvoiceHTLC> htlcs
    test('to test the property `htlcs`', () async {
      // TODO
    });

    // List of features advertised on the invoice.
    // BuiltList<FeaturesEntry> features
    test('to test the property `features`', () async {
      // TODO
    });

    // [LND only] Indicates if this invoice was a spontaneous payment that arrived via keysend[EXPERIMENTAL].
    // bool isKeysend
    test('to test the property `isKeysend`', () async {
      // TODO
    });

    //  The payment address of this invoice. This value will be used in MPP payments,     and also for newer invoices that always require the MPP payload for added end-to-end security.
    // String paymentAddr
    test('to test the property `paymentAddr`', () async {
      // TODO
    });

    // Signals whether or not this is an AMP invoice.
    // bool isAmp
    test('to test the property `isAmp`', () async {
      // TODO
    });
  });
}