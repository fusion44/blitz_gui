// ignore_for_file: avoid_print

import 'package:regtest_core/core.dart';
import 'package:regtest_headless/implementations/lightning_tests.dart';
import 'package:regtest_headless/implementations/onchain_tests.dart';
import 'package:regtest_headless/test_utils.dart';

var running = true;

NetworkManager manager = NetworkManager();

Future<void> _printImplementation(LnContainer n) async {
  var res = await n.api.getLightningApi().lightningGetInfoLightningGetInfoGet();
  if (res.statusCode != 200) {
    printResult(
      "Error(lnd1 get-info): ${res.statusMessage}",
      res: ResultType.nok,
    );
  }

  print("${res.data!.alias} implementation: ${res.data!.implementation}");
}

Future<void> getConfig() async {
  printSectionHeader("Config");
  for (final n in manager.lnNodes) {
    await _printImplementation(n);
  }

  printSectionFooter();
}

Future<void> test() async {
  await getConfig();

  // onchain
  await validateOnchainAddressGeneration();
  await validateSendOnchainNoFunds();

  // lightning
  await validateOpenChannelNoFunds();

  // fund the nodes with 15 BTC each
  await manager.fundNodes(autoMine: true);

  await validateSendOnchainFunds(manager);

  await manager.fundNodes(autoMine: true);
  await validateOpenChannelNoPush(manager);
  await validateOpenChannelWithPush(manager);

  await reset();
  printSectionFooter();
  printSummary();
}

Future<void> reset() async {
  final before = await manager.getWalletBalances();
  if (before.areEmpty) return;

  await manager.sweepAllChannels(autoMine: true);
  await manager.sweepOnchain(autoMine: true);

  final after = await manager.getWalletBalances();
  if (after.areNotEmpty) {
    print("Failed to sweep funds");
    if (after.haveOnchainFunds) {
      print("Still has onchain funds");
    }
    if (after.haveChannelFunds) {
      print("Still has channel funds");
    }
  }
}

void setup() async {
  manager.netStateStream.listen((event) async {
    if (event.status == NetworkStatus.checking ||
        event.status == NetworkStatus.startingUp) {
      return print(event.status);
    }
    if (event.status == NetworkStatus.down) {
      return await manager.start(
        autoFundNodes: false,
        exposeDataDirToHost: false,
      );
    }
    if (event.status == NetworkStatus.up) {
      // TODO: fixme
      // N.set({});
      return await test();
    }
    if (event.status == NetworkStatus.error) {
      return print("Error: ${event.message}");
    }
    print("Unhandled event: ${event.status}");
  });

  await manager.init();
}

void main(List<String> args) async {
  setup();
}
