import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:common/common.dart' show BtcValue;
import 'package:dio/dio.dart';
import 'package:regtest_core/core.dart';

import '../test_utils.dart';

Future<void> validateOnchainAddressGeneration() async {
  printGroupHeader("API generates valid bech32 addresses", sourceLine: 2);
  isValidAddress(String prefix, address) {
    if (isValidRegtestBech32Address(address)) {
      return printResult("$prefix new-address: $address");
    }

    return printResult("new-address: $address", res: ResultType.nok);
  }

  final clngAddress = await N.CLNgRPC!.newAddress();
  isValidAddress(N.CLNgRPC!.lnInfo.implementation, clngAddress);

  final clnjAddress = await N.CLNjRPC!.newAddress();
  isValidAddress(N.CLNjRPC!.lnInfo.implementation, clnjAddress);

  final lndgAddress = await N.LNDgRPC!.newAddress();
  isValidAddress(N.LNDgRPC!.lnInfo.implementation, lndgAddress);
}

Future<bool> _validateSendOnchainFailureCode412(
  LnNode sender,
  LnNode receiver, [
  int amountSat = 500000,
]) async {
  // Check if the send onchain throws a proper 412 error when not enough
  // onchain balance is available
  final sBalance = await sender.walletBalance();
  if (sBalance.onchainTotalBalance > amountSat) {
    printResult(
      "${sender.lnInfo.implementation}: Precondition Error: Sender balance to high: ${sBalance.onchainTotalBalance} sats",
      res: ResultType.nok,
    );

    return false;
  }

  final address = await receiver.newAddress();
  try {
    final builder = SendCoinsInputBuilder();
    builder.address = address;
    builder.amount = amountSat;

    final res = await sender.api
        .getLightningApi()
        .lightningSendCoinsLightningSendCoinsPost(
          sendCoinsInput: builder.build(),
        );

    printResult(
      "${sender.lnInfo.implementation}: code: ${res.statusCode}",
      res: ResultType.nok,
    );
  } on DioError catch (e) {
    final code = e.response!.statusCode;
    var res = ResultType.nok;

    if (code == 412) {
      res = ResultType.ok;
    }

    final data = e.response!.data;
    var detailMessage = "";
    if (data is Map<String, dynamic>) {
      detailMessage = data["detail"];
    }

    printResult(
      "${sender.lnInfo.implementation}: code: ${e.response!.statusCode}",
      res: res,
      detail: detailMessage,
    );
  }

  return false;
}

Future<void> validateSendOnchainNoFunds() async {
  printGroupHeader("send-coins throws 412 on insufficient onchain balance");
  await _validateSendOnchainFailureCode412(N.CLNgRPC!, N.LNDgRPC!);
  await _validateSendOnchainFailureCode412(N.CLNjRPC!, N.LNDgRPC!);
  await _validateSendOnchainFailureCode412(N.LNDgRPC!, N.CLNjRPC!);
}

Future<void> validateSendOnchainFunds(NetworkManager mgr) async {
  printGroupHeader(
    "send-coins sends the correct amount of sats to the receiver",
  );
  await _sendOnChainFixedAmount(mgr, N.CLNgRPC!, N.LND2gRPC!);
  await _sendOnChainFixedAmount(mgr, N.CLNjRPC!, N.LND2gRPC!);
  await _sendOnChainFixedAmount(mgr, N.LNDgRPC!, N.LND2gRPC!);

  // sometimes the some sender implementations haven't confirmed all onchain
  // after the send above. We must wait for them too. Especially CLN is slow
  // here.
  await mgr.waitOnchainConfirmed();

  printGroupHeader("send-coins with send-all arg sweeps onchain funds");
  await _sendOnChainAll(mgr, N.CLNgRPC!, N.LND2gRPC!);
  await _sendOnChainAll(mgr, N.CLNjRPC!, N.LND2gRPC!);
  await _sendOnChainAll(mgr, N.LNDgRPC!, N.LND2gRPC!);
}

Future<void> _sendOnChainFixedAmount(
  NetworkManager mgr,
  LnNode sender,
  LnNode receiver, [
  int amountSat = 500001,
]) async {
  final sBefore = await sender.walletBalance();
  final rBefore = await receiver.walletBalance();
  int newBalance = rBefore.onchainTotalBalance + amountSat;

  final address = await receiver.newAddress();
  try {
    final amt = BtcValue.fromSats(amountSat);
    final builder = SendCoinsInputBuilder();
    builder.address = address;
    builder.amount = amountSat;

    final res = await sender.api
        .getLightningApi()
        .lightningSendCoinsLightningSendCoinsPost(
          sendCoinsInput: builder.build(),
        );

    final data = res.data;
    if (data == null) {
      return printResult(
        "${sender.lnInfo.implementation}: code: ${res.statusCode} but no data.",
        res: ResultType.nok,
      );
    }

    // This is not a send all tx, so the sendAll field in the
    // Response should be false
    if (!_sendAllIsOK(sender, data, targetState: false)) return;

    // wait for the tx to be propagated
    await Future.delayed(Duration(seconds: 1));

    final txData = await sender.api
        .getBitcoinCoreApi()
        .bitcoinGetRawTransactionBitcoinGetRawTransactionGet(txid: data.txid);

    final vout = txData.data!.vout.toList();
    final lVout = vout.length;

    Map? output;
    Map? changeOutput;
    for (var o in vout) {
      // find the output that belongs to our destination address
      if (o.asMap["value"] != 0.0) {
        final out = o.asMap["scriptPubKey"];
        final outAddress = out["desc"] as String;

        if (outAddress.contains(address)) {
          output = o.asMap;
          continue;
        }

        changeOutput = o.asMap;
      }
    }

    if (output == null) {
      return printResult(
        "${sender.lnInfo.implementation}: code: ${res.statusCode} but no output found.",
        res: ResultType.nok,
        detail: vout.toString(),
      );
    }

    if (changeOutput == null) {
      return printResult(
        "${sender.lnInfo.implementation}: code: ${res.statusCode} but no change output found.",
        res: ResultType.nok,
        detail: vout.toString(),
      );
    }

    // the value in BTC as transmitted to the mempool
    final txVal = output["value"];
    final sent = BtcValue.fromBtc(txVal);

    // Check the amount in the tx
    if (sent != amt) {
      final detail =
          "input: ${amt.btcTotal}btc != sent: ${sent.btcTotal}sats; length vout: $lVout\n$vout";
      return printResult(
        "${sender.lnInfo.implementation}: code: ${res.statusCode} but wrong amount in tx",
        res: ResultType.nok,
        detail: detail,
      );
    }

    if (vout.length != 2) {
      // if vout is not of length 2, something is fishy
      // we expect a change output and the output to the receiver
      return printResult(
        "${sender.lnInfo.implementation}: code: ${res.statusCode} but wrong amount of outputs in tx",
        res: ResultType.nok,
        detail: vout.toString(),
      );
    }

    // the change value in BTC as transmitted to the mempool
    final change = BtcValue.fromBtc(changeOutput["value"]);

    final sAfter = await sender.walletBalance();
    var rAfter = await receiver.walletBalance();

    int n = 0;
    while (true) {
      // Mine blocks until the tx is confirmed fully
      await mgr.mineBlocks(1);
      await Future.delayed(Duration(seconds: 1));

      rAfter = await receiver.walletBalance();

      // check if the receiver wallet balance is properly updated
      if (newBalance == rAfter.onchainTotalBalance &&
          rAfter.onchainUnconfirmedBalance == 0) {
        printResult(
          "${sender.lnInfo.implementation}: sent: ${sent.btcTotal}btc, change: ${change.btcTotal}btc",
          res: ResultType.ok,
        );

        break;
      }

      n++;

      if (n == 5) {
        return printResult(
          "${sender.lnInfo.implementation}: code: ${res.statusCode}, receiver wallet balance not updated after 5 blocks",
          res: ResultType.nok,
          detail:
              "receiver WalletBalance before: $rAfter,  WalletBalance after: $sAfter, amt send: $amt",
        );
      }
    }
  } on DioError catch (e) {
    final code = e.response!.statusCode;
    var res = ResultType.nok;

    if (code == 412) {
      res = ResultType.ok;
    }

    final data = e.response!.data;
    var detailMessage = "";
    if (data is Map<String, dynamic>) {
      detailMessage = data["detail"];
    }

    detailMessage += """\n
      Sender WalletBalances:
      oc    ${sBefore.onchainConfirmedBalance.toString()}
      ouc   ${sBefore.onchainUnconfirmedBalance.toString()}
      clb   ${sBefore.channelLocalBalance.toString()}
      polb  ${sBefore.channelPendingOpenLocalBalance.toString()}
      cporb ${sBefore.channelPendingOpenRemoteBalance.toString()}
      crb   ${sBefore.channelRemoteBalance.toString()}
      culb  ${sBefore.channelUnsettledLocalBalance.toString()}
      curb ${sBefore.channelUnsettledRemoteBalance.toString()}
    """;

    printResult(
      "${sender.lnInfo.implementation}: code: ${e.response!.statusCode}",
      res: res,
      detail: detailMessage,
    );
  }
}

Future<void> _sendOnChainAll(
    NetworkManager mgr, LnNode sender, LnNode receiver) async {
  final sBefore = await sender.walletBalance();

  final address = await receiver.newAddress();
  try {
    final builder = SendCoinsInputBuilder();
    builder.address = address;
    builder.sendAll = true;

    final res = await sender.api
        .getLightningApi()
        .lightningSendCoinsLightningSendCoinsPost(
          sendCoinsInput: builder.build(),
        );

    final data = res.data;
    if (data == null) {
      return printResult(
        "${sender.lnInfo.implementation}: code: ${res.statusCode} but no data.",
        res: ResultType.nok,
      );
    }

    // This is a send all tx, so the sendAll field in the
    // Response should be true
    if (!_sendAllIsOK(sender, data, targetState: true)) return;

    // wait for the tx to be propagated
    await Future.delayed(Duration(seconds: 1));

    final txData = await sender.api
        .getBitcoinCoreApi()
        .bitcoinGetRawTransactionBitcoinGetRawTransactionGet(txid: data.txid);

    final vout = txData.data!.vout.toList();

    Map? output;
    for (var o in vout) {
      // find the output that belongs to our destination address
      if (o.asMap["value"] != 0.0) {
        final out = o.asMap["scriptPubKey"];
        final outAddress = out["desc"] as String;

        if (outAddress.contains(address)) {
          output = o.asMap;
          break;
        }
      }
    }

    if (output == null) {
      return printResult(
        "${sender.lnInfo.implementation}: code: ${res.statusCode} but no output found.",
        res: ResultType.nok,
        detail: vout.toString(),
      );
    }

    int n = 0;
    while (true) {
      // Mine blocks until the tx is confirmed fully
      await mgr.mineBlocks(1);
      await Future.delayed(Duration(seconds: 1));

      final sAfter = await sender.walletBalance();
      if (sAfter.isEmpty) {
        printResult(
          "${sender.lnInfo.implementation}: sent all funds. Total WalletBalance is 0",
          res: ResultType.ok,
        );

        break;
      }

      n++;

      if (n == 5) {
        return printResult(
          "${sender.lnInfo.implementation}: code: ${res.statusCode}, receiver wallet balance not updated after 5 blocks",
          res: ResultType.nok,
          detail:
              "receiver WalletBalance before: $sAfter,  WalletBalance after: $sAfter, amt send: $sBefore",
        );
      }
    }
  } on DioError catch (e) {
    final code = e.response!.statusCode;
    var res = ResultType.nok;

    if (code == 412) {
      res = ResultType.ok;
    }

    final data = e.response!.data;
    var detailMessage = "";
    if (data is Map<String, dynamic>) {
      detailMessage = data["detail"];
    }

    detailMessage += """\n
      Sender WalletBalances:
      oc    ${sBefore.onchainConfirmedBalance.toString()}
      ouc   ${sBefore.onchainUnconfirmedBalance.toString()}
      clb   ${sBefore.channelLocalBalance.toString()}
      polb  ${sBefore.channelPendingOpenLocalBalance.toString()}
      cporb ${sBefore.channelPendingOpenRemoteBalance.toString()}
      crb   ${sBefore.channelRemoteBalance.toString()}
      culb  ${sBefore.channelUnsettledLocalBalance.toString()}
      curb ${sBefore.channelUnsettledRemoteBalance.toString()}
    """;

    printResult(
      "${sender.lnInfo.implementation}: code: ${e.response!.statusCode}",
      res: res,
      detail: detailMessage,
    );
  }
}

bool _sendAllIsOK(
  LnNode i,
  SendCoinsResponse data, {
  required bool targetState,
}) {
  final sendAll = data.sendAll;
  if (sendAll != null && sendAll != targetState) {
    // This was not a send_all tx, so this is wrong
    printResult(
      "${i.lnInfo.implementation}: not a send_all tx, but sendAll in Response is true.",
      res: ResultType.nok,
    );

    return false;
  }

  return true;
}
