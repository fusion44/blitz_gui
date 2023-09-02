import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:regtest_core/core.dart';

import '../test_utils.dart';

Future<void> _validateOpenChannelNoFundsFailureCode412({
  required LnContainer from,
  required LnContainer to,
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

Future<void> _validateOpensChan(
  NetworkManager mgr,
  LnContainer from,
  LnContainer to, {
  int amountSat = 1000000,
  BtcValue? pushSat,
  bool waitForOpen = true,
  int maxWaitIterations = 15,
}) async {
  pushSat = pushSat ?? BtcValue.zero();
  final sBalance = await from.walletBalance();
  if (sBalance.onchainTotalBalance < amountSat) {
    printResult(
      "${from.lnInfo.implementation}: Precondition Error: Sender balance to low: ${sBalance.onchainTotalBalance} sats",
      res: ResultType.nok,
    );

    return;
  }

  final startingChannels = await from.fetchChannels();
  if (startingChannels.isNotEmpty) {
    printResult(
      "${from.lnInfo.implementation}: Precondition Error: Opening node already has channels open",
      res: ResultType.nok,
      detail:
          "Num channels: ${startingChannels.length}, first channel: ${startingChannels.first}",
    );

    return;
  }

  try {
    final res = await from.api
        .getLightningApi()
        .lightningOpenChannelLightningOpenChannelPost(
          localFundingAmount: amountSat,
          nodeURI: to.fullUri,
          pushAmountSat: pushSat.satsTotal,
        );

    if (!waitForOpen) {
      return printResult(
        "${from.lnInfo.implementation}: code: ${res.statusCode} channel open initiated, but not yet confirmed.",
        res: ResultType.ok,
      );
    }

    int numBlocks = 0;
    while (true) {
      if (numBlocks == maxWaitIterations) {
        return printResult(
          "${from.lnInfo.implementation}: Timeout waiting $numBlocks blocks for the channel to open",
          res: ResultType.nok,
        );
      }

      final btcc = NetworkManager().findFirstOf<BitcoinCoreContainer>();
      if (btcc == null) {
        throw StateError('BitcoinCoreContainer not found');
      }

      await btcc.mineBlocks(MineBlockData(1));
      await Future.delayed(Duration(seconds: 2));
      numBlocks++;

      var channels = await from.fetchChannels();
      if (channels.isNotEmpty) {
        final c = channels.first;
        final active = c.channel.active;
        String id = c.channel.channelId ?? "";
        if (id.length > 20) {
          id = "${id.substring(0, 10)}...${id.substring(id.length - 12)}";
        }

        if (active && id.isNotEmpty && c.otherFunds == pushSat) {
          return printResult(
            "${from.lnInfo.implementation}: channel with id $id open after $numBlocks blocks. Push amount of $pushSat is correct",
            res: ResultType.ok,
          );
        }

        if (active && id.isNotEmpty && c.otherFunds != pushSat) {
          return printResult(
              "${from.lnInfo.implementation}: channel with id $id open after $numBlocks blocks, but push amount is wrong",
              res: ResultType.nok,
              detail:
                  "Expected push amount: $pushSat, actual: ${c.otherFunds}");
        }
      }
    }
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

Future<void> validateOpenChannelNoPush(NetworkManager manager) async {
  printGroupHeader(
    "open-channel opens a channel with sufficient funds; no push",
  );
  // make sure all funds are confirmed
  await manager.sweepAllChannels(autoMine: true);
  await manager.waitOnchainConfirmed();

  await manager.getWalletBalances();

  await _validateOpensChan(
    manager,
    N.CLNgRPC!,
    N.LNDgRPC!,
    pushSat: BtcValue.fromSats(250000),
  );
  await _validateOpensChan(
    manager,
    N.CLNjRPC!,
    N.LNDgRPC!,
    pushSat: BtcValue.fromSats(350000),
  );
  await _validateOpensChan(
    manager,
    N.LNDgRPC!,
    N.CLNjRPC!,
    pushSat: BtcValue.fromSats(500000),
  );

  await manager.getWalletBalances();

  final btcc = manager.findFirstOf<BitcoinCoreContainer>();
  if (btcc == null) {
    throw StateError('BitcoinCoreContainer not found');
  }

  await btcc.mineBlocks(MineBlockData(10, true, 2, 2));

  // channels should be open and be listed
  printGroupHeader("Channel should be open after 10 new blocks");
  // await _validateChanIsOpen(from: N.CLNjRPC!, to: N.LNDgRPC!, pushSat: 350000);
  // await _validateChanIsOpen(from: N.CLNgRPC!, to: N.LNDgRPC!, pushSat: 250000);
  // await _validateChanIsOpen(from: N.LNDgRPC!, to: N.CLNjRPC!, pushSat: 500000);
}

Future<void> validateOpenChannelWithPush(NetworkManager manager) async {
  printGroupHeader(
    "open-channel opens a channel with sufficient funds; with push",
  );

  // make sure all funds are confirmed
  await manager.sweepAllChannels(autoMine: true);
  await manager.waitOnchainConfirmed();

  await _validateOpensChan(
    manager,
    N.CLNgRPC!,
    N.LND3gRPC!,
    pushSat: BtcValue.fromSats(250000),
  );
  await _validateOpensChan(
    manager,
    N.CLNjRPC!,
    N.LND3gRPC!,
    pushSat: BtcValue.fromSats(551235),
  );
  await _validateOpensChan(
    manager,
    N.LNDgRPC!,
    N.LND3gRPC!,
    pushSat: BtcValue.fromSats(1234),
  );
}
