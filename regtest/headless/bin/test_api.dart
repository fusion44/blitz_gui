// ignore_for_file: avoid_print

import 'package:regtest_core/core.dart';
import 'package:regtest_headless/implementations/lightning_tests.dart';
import 'package:regtest_headless/implementations/onchain_tests.dart';
import 'package:regtest_headless/test_utils.dart';

var running = true;

NetworkManager manager = NetworkManager();

Future<void> _printImplementation(LnNode n) async {
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
  for (final n in manager.nodeMap.values) {
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

  await validateOpenChannel(manager);

  await reset();

  printSectionFooter();
  printSummary();
}

Future<void> reset() async {
  final before = await manager.getWalletBalances();
  if (before.areEmpty) {
    print("No funds to sweep");
    return;
  }

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
  manager.stream.listen((event) async {
    if (event.state == NetworkState.checking ||
        event.state == NetworkState.startingUp) {
      return print(event.state);
    }
    if (event.state == NetworkState.down) {
      return await manager.start(
        autoFundNodes: false,
        exposeDataDirToHost: false,
      );
    }
    if (event.state == NetworkState.up) {
      N.set(manager.nodeMap);
      return await test();
    }
    if (event.state == NetworkState.error) {
      return print("Error: ${event.message}");
    }
    print("Unhandled event: ${event.state}");
  });

  await manager.init();
}

void main(List<String> args) async {
  setup();
}
