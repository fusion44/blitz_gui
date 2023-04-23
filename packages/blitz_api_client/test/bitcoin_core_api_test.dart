import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

/// tests for BitcoinCoreApi
void main() {
  final instance = BlitzApiClient().getBitcoinCoreApi();

  group(BitcoinCoreApi, () {
    // Subscribe to incoming blocks.
    //
    // Similar to Bitcoin Core getblock  SSE endpoint to receive new block information as soon as it is appended to chain.  If verbosity is 0, returns a string that is serialized, hex-encoded data for block 'hash'.<br> If verbosity is 1, returns an Object with information about block <hash>.<br> If verbosity is 2, returns an Object with information about block <hash> and information about each transaction.<br>
    //
    //Future<JsonObject> bitcoinBlockSubBitcoinBlockSubGet({ int verbosity }) async
    test('test bitcoinBlockSubBitcoinBlockSubGet', () async {
      // TODO
    });

    // Bitcoin.Btc-Info
    //
    // Get general information about bitcoin core. Combines most important information from `getblockchaininfo` and `getnetworkinfo`
    //
    //Future<BtcInfo> bitcoinBtcInfoBitcoinBtcInfoGet() async
    test('test bitcoinBtcInfoBitcoinBtcInfoGet', () async {
      // TODO
    });

    // Get current fee estimation from Bitcoin Core
    //
    // Estimates the fee for the given parameters.     See documentation on [bitcoin.org](https://developer.bitcoin.org/reference/rpc/estimatesmartfee.html)
    //
    //Future<int> bitcoinEstimateFeeBitcoinEstimateFeeGet({ int targetConf, FeeEstimationMode mode }) async
    test('test bitcoinEstimateFeeBitcoinEstimateFeeGet', () async {
      // TODO
    });

    // Get the current block count
    //
    // See documentation on [bitcoincore.org](https://bitcoincore.org/en/doc/0.21.0/rpc/blockchain/getblockcount/)
    //
    //Future<JsonObject> bitcoinGetBlockCountBitcoinGetBlockCountGet() async
    test('test bitcoinGetBlockCountBitcoinGetBlockCountGet', () async {
      // TODO
    });

    // Get the current blockchain status
    //
    // See documentation on [bitcoincore.org](https://bitcoincore.org/en/doc/0.21.0/rpc/blockchain/getblockchaininfo/)
    //
    //Future<BlockchainInfo> bitcoinGetBlockchainInfoBitcoinGetBlockchainInfoGet() async
    test('test bitcoinGetBlockchainInfoBitcoinGetBlockchainInfoGet', () async {
      // TODO
    });

    // Get information about the network
    //
    // See documentation on [bitcoincore.org](https://bitcoincore.org/en/doc/0.21.0/rpc/network/getnetworkinfo/)
    //
    //Future<NetworkInfo> bitcoinGetNetworkInfoBitcoinGetNetworkInfoGet() async
    test('test bitcoinGetNetworkInfoBitcoinGetNetworkInfoGet', () async {
      // TODO
    });

    // Get information about a raw transaction
    //
    // See documentation on [bitcoincore.org](https://bitcoincore.org/en/doc/22.0.0/rpc/rawtransactions/getrawtransaction/)
    //
    //Future<RawTransaction> bitcoinGetRawTransactionBitcoinGetRawTransactionGet(String txid) async
    test('test bitcoinGetRawTransactionBitcoinGetRawTransactionGet', () async {
      // TODO
    });
  });
}
