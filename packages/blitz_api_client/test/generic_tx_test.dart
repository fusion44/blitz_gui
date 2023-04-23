import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for GenericTx
void main() {
  final instance = GenericTxBuilder();
  // TODO add properties to the builder and call build()

  group(GenericTx, () {
    // The index of the transaction.
    // int index (default value: 0)
    test('to test the property `index`', () async {
      // TODO
    });

    //  Unique identifier for this transaction.  Depending on the type of the transaction it will be different: #### On-chain The transaction hash  #### Lightning Invoice and Payment The payment request
    // String id
    test('to test the property `id`', () async {
      // TODO
    });

    // Whether this is an onchain (**onchain**) or lightning (**ln**) transaction.
    // TxCategory category
    test('to test the property `category`', () async {
      // TODO
    });

    // Whether this is an outgoing (**send**) transaction or an incoming (**receive**) transaction.
    // TxType type
    test('to test the property `type`', () async {
      // TODO
    });

    //  The value of the transaction, depending on the category in satoshis or millisatoshis.  #### On-chain Transaction amount in satoshis  #### Lightning Invoice * value in millisatoshis of the invoice if *unsettled* * amount in millisatoshis paid if invoice is *settled*  #### Lightning Payment * amount sent in millisatoshis
    // int amount
    test('to test the property `amount`', () async {
      // TODO
    });

    //  The unix timestamp in seconds for the transaction.  The timestamp can mean different things in different situations:  #### Lightning Invoice * Creation date for in-flight or failed invoices * Settle date for succeeded invoices  #### On-chain * Creation date for transaction waiting in the mempool * Timestamp of the block where this transaction is included  #### Lightning Payment
    // int timeStamp
    test('to test the property `timeStamp`', () async {
      // TODO
    });

    // Optional comment for this transaction
    // String comment (default value: '')
    test('to test the property `comment`', () async {
      // TODO
    });

    //  The status of the transaction. Depending on the transaction category this can be different values:  May have different meanings in different situations: #### unknown An unknown state was found.  #### in_flight * A lightning payment is being sent * An invoice is waiting for the incoming payment * An on-chain transaction is waiting in the mempool  #### succeeded * A lighting payment was successfully sent * An incoming payment was received for an invoice * An on-chain transaction was included in a block  #### failed * A lightning payment attempt which could not be completed (no route found, insufficient funds, ...) * An invoice is expired or some other error happened
    // TxStatus status
    test('to test the property `status`', () async {
      // TODO
    });

    // Block height, if included in a block. Only applicable for category **onchain**.
    // int blockHeight
    test('to test the property `blockHeight`', () async {
      // TODO
    });

    // Number of confirmations. Only applicable for category **onchain**.
    // int numConfs
    test('to test the property `numConfs`', () async {
      // TODO
    });

    // Total fees paid for this transaction
    // int totalFees
    test('to test the property `totalFees`', () async {
      // TODO
    });
  });
}
