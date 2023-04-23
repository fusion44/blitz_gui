import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../constants.dart';
import '../utils.dart';

const walletName = "regtest";

Future<void> ensureWalletLoaded() async {
  try {
    final output = await _bitcoindCommand(['loadwallet', walletName]);
    final json = jsonDecode(output);
    if (json["walletname"] != null && json["walletname"] == walletName) {
      return;
    }
  } catch (e) {
    final error = e.toString();
    if (error.contains(
        "SQLiteDatabase: Unable to obtain an exclusive lock on the database")) {
      // wallet is loaded
      return;
    }

    logMessage("Creating Bitcoin Core wallet $walletName");
  }

  await _bitcoindCommand(['createwallet', walletName]);
}

Future<String> fundFromDaemonWallet(String address,
    [double amountInBtc = 15.0]) async {
  try {
    final output = await _bitcoindCommand([
      "-named",
      "sendtoaddress",
      "address=$address",
      "amount=$amountInBtc",
      "fee_rate=100"
    ]);

    if (output.isNotEmpty) {
      return output.trim();
    }

    logMessage(
      "Something went wrong trying to send funds from Bitcoin Core to $address",
    );
  } catch (e) {
    logMessage(e.toString());
  }

  return "error, see logs";
}

Future<void> doMineBlocks([int numBlocks = 1]) async {
  try {
    final output = await _bitcoindCommand(['-generate', '$numBlocks']);
    final json = jsonDecode(output);
    if (json["address"] != null &&
        json["blocks"] != null &&
        json["blocks"].length == numBlocks) {
      return;
    }

    logMessage("Something went wrong trying to mine $numBlocks blocks");
  } catch (e) {
    logMessage(e.toString());
  }
}

Future<String> getNewAddress() async {
  try {
    final output = await _bitcoindCommand(['getnewaddress']);
    if (output.isNotEmpty) {
      return output.trim();
    }

    logMessage("Something went wrong trying to get a new address");
  } catch (e) {
    logMessage(e.toString());
  }

  return "error, see logs";
}

Future<String> _bitcoindCommand(List<String> args) async {
  final c = Completer<String>();
  final p = await Process.start('docker', [
    'exec',
    '$projectName-bitcoind-1',
    'bitcoin-cli',
    '-rpcuser=regtester',
    '-rpcpassword=regtester',
    '-regtest',
    ...args,
  ]);

  p.stdout.transform(utf8.decoder).listen(
        (event) => c.complete(event),
        onError: (error) => c.completeError(error),
      );

  p.stderr.transform(utf8.decoder).listen((error) => c.completeError(error));

  return c.future;
}
