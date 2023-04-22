import 'package:blitz_api_client/blitz_api_client.dart';
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
