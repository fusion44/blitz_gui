import 'package:dio/dio.dart';
import 'package:regtest_core/core.dart';

import '../test_utils.dart';

Future<void> _validateOpenChannelNoFundsFailureCode412({
  required LnNode from,
  required LnNode to,
  int amountSat = 500000,
}) async {
  // Check if the open channel throws a proper 412 error when not enough
  // onchain balance is available
  final sBalance = await from.walletBalance();
  if (sBalance.onchainTotalBalance > amountSat) {
    printResult(
      "${from.lnInfo.implementation}: Precondition Error: Sender balance to high: ${sBalance.onchainTotalBalance} sats",
      res: ResultType.nok,
    );

    return;
  }

  try {
    await from.api
        .getLightningApi()
        .lightningOpenChannelLightningOpenChannelPost(
          localFundingAmount: amountSat,
          nodeURI: to.fullUri,
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
      "${from.lnInfo.implementation}: code: ${e.error}",
      res: res,
      detail: detailMessage,
    );
  }
}

Future<void> validateOpenChannelNoFunds() async {
  printGroupHeader(
    "open-channel throws 412 on opening a channel with insufficient funds",
  );

  await _validateOpenChannelNoFundsFailureCode412(
    from: N.CLNgRPC!,
    to: N.LNDgRPC!,
    amountSat: 500000,
  );

  await _validateOpenChannelNoFundsFailureCode412(
    from: N.CLNjRPC!,
    to: N.LNDgRPC!,
    amountSat: 500000,
  );

  await _validateOpenChannelNoFundsFailureCode412(
    from: N.LNDgRPC!,
    to: N.CLNjRPC!,
    amountSat: 500000,
  );
}

Future<void> _validateOpensChan({
  required LnNode from,
  required LnNode to,
  int amountSat = 1000000,
  int pushSat = 0,
}) async {
  final sBalance = await from.walletBalance();
  if (sBalance.onchainTotalBalance < amountSat) {
    printResult(
      "${from.lnInfo.implementation}: Precondition Error: Sender balance to low: ${sBalance.onchainTotalBalance} sats",
      res: ResultType.nok,
    );

    return;
  }

  try {
    final res = await from.api
        .getLightningApi()
        .lightningOpenChannelLightningOpenChannelPost(
          localFundingAmount: amountSat,
          nodeURI: to.fullUri,
          pushAmountSat: pushSat,
        );

    printResult(
      "${from.lnInfo.implementation}: code: ${res.statusCode}",
      res: ResultType.ok,
    );
  } on DioError catch (e) {
    // We should not get an error here
    final data = e.response!.data;
    var detailMessage = "";
    if (data is Map<String, dynamic>) {
      detailMessage = data["detail"];
    }

    printResult(
      "${from.lnInfo.implementation}: code: ${e.error}",
      res: ResultType.nok,
      detail: detailMessage,
    );
  }
}

Future<void> _validateChanIsOpen({
  required LnNode from,
  required LnNode to,
  int pushSat = 0,
}) async {
  try {
    final res = await from.api
        .getLightningApi()
        .lightningListChannelsLightningListChannelsGet();

    printResult(
      "${from.lnInfo.implementation}: code: ${res.statusCode}",
      res: ResultType.ok,
    );
  } on DioError catch (e) {
    // We should not get an error here
    final data = e.response!.data;
    var detailMessage = "";
    if (data is Map<String, dynamic>) {
      detailMessage = data["detail"];
    }

    printResult(
      "${from.lnInfo.implementation}: code: ${e.error}",
      res: ResultType.nok,
      detail: detailMessage,
    );
  }
}

Future<void> validateOpenChannel(NetworkManager manager) async {
  printGroupHeader("open-channel opens a channel with sufficient funds");
  // make sure all funds are confirmed
  await manager.waitOnchainConfirmed();

  await manager.getWalletBalances();

  await _validateOpensChan(from: N.CLNgRPC!, to: N.LNDgRPC!, pushSat: 250000);
  await _validateOpensChan(from: N.CLNjRPC!, to: N.LNDgRPC!, pushSat: 350000);
  await _validateOpensChan(from: N.LNDgRPC!, to: N.CLNjRPC!, pushSat: 500000);

  await manager.getWalletBalances();

  await manager.mineBlocks(10, delayBetweenBlocks: 2);

  // channels should be open and be listed
  printGroupHeader("Channel should be open after 10 new blocks");
  await _validateChanIsOpen(from: N.CLNgRPC!, to: N.LNDgRPC!, pushSat: 250000);
  await _validateChanIsOpen(from: N.CLNjRPC!, to: N.LNDgRPC!, pushSat: 350000);
  await _validateChanIsOpen(from: N.LNDgRPC!, to: N.CLNjRPC!, pushSat: 500000);
}
