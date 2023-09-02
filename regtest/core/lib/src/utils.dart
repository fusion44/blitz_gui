// ignore_for_file: avoid_print

library utils;

import 'dart:async';
import 'dart:io' show Directory, PathAccessException, Platform, Process;
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:english_words/english_words.dart';
import 'package:regtest_core/core.dart';

int validIntOrZero(String text) {
  final val = int.tryParse(text.replaceAll(",", ""));
  if (val == null) {
    logMessage("Warning: Could not parse $text");
    return 0;
  }

  return val;
}

class JunkingStatusUpdate {
  final String msg;
  final int percent;

  JunkingStatusUpdate(this.msg, this.percent);
}

Stream<JunkingStatusUpdate> addJunkTx(AddJunkTxDlgData d) async* {
  final int total = d.numInvoices + d.numPayments + d.numOnchainTx;
  final frac = 100 / total;
  final rand = Random();

  int invoicesCreated = 0;
  int paysCreated = 0;
  int onchainTxCreated = 0;

  int numIncoming = d.numOnchainTx ~/ 2;

  final list = <int>[
    ...List<int>.filled(d.numInvoices, 0),
    ...List<int>.filled(d.numPayments, 1),
    ...List<int>.filled(numIncoming, 2), // incoming
    ...List<int>.filled(d.numOnchainTx - numIncoming, 3), // outgoing
  ]..shuffle();

  var count = 0;
  for (final i in list) {
    final cParty = getRandNode(d.node);

    int numSats = 10000;
    if (d.satsRangeLower != d.satsRangeUpper) {
      numSats = rand.nextInt(d.satsRangeUpper) + d.satsRangeLower;
    }

    if (i == 0) {
      try {
        final b11 = await d.node.genInvoice(
          GenInvoiceDialogData(
            node: d.node,
            mSat: numSats,
            payer: cParty,
            msg: genRandomWords(Random().nextInt(5) + 5),
          ),
        );

        invoicesCreated++;
        await cParty.payInvoice(PayInvoiceData(b11));
      } catch (e) {
        logMessage(e.toString());
      }
    } else if (i == 1) {
      try {
        final b11 = await cParty.genInvoice(
          GenInvoiceDialogData(
            node: cParty,
            mSat: numSats,
            msg: genRandomWords(Random().nextInt(5) + 5),
          ),
        );
        await d.node.payInvoice(PayInvoiceData(b11));
      } catch (e) {
        logMessage(e.toString());
      }

      paysCreated++;
    } else if (i == 2) {
      try {
        final c = NetworkManager().findComplementaryNode(d.node);
        if (c == null) continue;

        final addr = await c.newLightningAddress();
        cParty.sendOnChain(numSats, addr);
      } catch (e) {
        logMessage(e.toString());
      }
    } else if (i == 3) {
      try {
        final c = NetworkManager().findComplementaryNode(cParty);
        if (c == null) continue;

        final addr = await c.newLightningAddress();
        await d.node.sendOnChain(numSats, addr);
      } catch (e) {
        logMessage(e.toString());
      }
    }

    if (i == 2 || i == 3) {
      try {
        final btcc = NetworkManager().findFirstOf<BitcoinCoreContainer>();
        if (btcc == null) {
          throw StateError('BitcoinCoreContainer not found');
        }

        await btcc.mineBlocks(MineBlockData(rand.nextInt(6) + 3));

        onchainTxCreated++;
      } catch (e) {
        logMessage(e.toString());
      }
    }

    final perc = (frac * count).toInt();
    count++;

    if (d.delay) {
      int randDelay = rand.nextInt(d.delayUpper) + d.delayLower;
      for (var i = 0; i < randDelay; i++) {
        yield (JunkingStatusUpdate("Next action in ${randDelay - i} s", perc));
        await Future.delayed(const Duration(seconds: 1));
      }
      yield (JunkingStatusUpdate("Working ...", perc));

      continue;
    }
  }

  yield JunkingStatusUpdate("", 100);
  logMessage(
    "Finished creating $invoicesCreated invoices, $paysCreated pays and $onchainTxCreated onchain tx",
  );
}

LnNode getRandNode([LnNode? exclude]) {
  final nodes = NetworkManager().lnNodes;
  if (exclude != null) nodes.remove(exclude);
  int rand = Random().nextInt(nodes.length - 1);

  return nodes[rand];
}

String genRandomWords([int numWords = 5]) {
  var msg = "";
  generateWordPairs().take(numWords).forEach((w) {
    msg += ("${w.first[0].toUpperCase()}${w.first.substring(1)} ");
  });

  return msg.trimRight();
}

int clnParseMSatOrZero(String amt) =>
    int.tryParse(amt.replaceAll("msat", "")) ?? 0;

void printDioError(DioError e, String text) {
  final header =
      '=== ${e.response?.statusCode} - ${e.response?.statusMessage} ===';
  final footer = '=' * header.length;
  logMessage(
    '''$text
$header
${e.response?.data}
${e.stackTrace}
$footer''',
  );
}

Map<String, String> envVars = Platform.environment;
final testing = envVars['REGTEST-HEADLESS'];

bool isHeadless() {
  if (testing == null || testing == "0" || testing == "false") {
    return false;
  }

  return true;
}

void logMessage(String message) {
  if (!isHeadless()) {
    print(message);
  }
}

Future<void> prepareDataDir([String dir = dockerDataDir]) async {
  final directory = Directory(dir);

  if (await directory.exists()) {
    logMessage("$dir exists => deleting ...");

    await directory.delete(recursive: true);
  }
  logMessage("Creating data directory $dir");

  try {
    await directory.create(recursive: true);
  } on PathAccessException catch (e) {
    logMessage(e.toString());
  }
}

Future<void> makeDataDirsPublic([String dir = dockerDataDir]) async {
  // Docker is usually a root run application, so the data directories
  // are owned by root. This makes it hard to access the data
  // change ownership from root to current user

  final su = isHeadless() ? 'sudo' : 'pkexec';
  await Process.run(
    su,
    ["chmod" "-R", "777", Directory(dockerDataDir).absolute.path],
    workingDirectory: dockerDataDir,
  );

  // TODO: unhardcodify the username
  await Process.run(
    su,
    ["chown", "-R", "f44", Directory(dockerDataDir).absolute.path],
    workingDirectory: dockerDataDir,
  );
}

Future<void> cleanDataDirectories([String dir = dockerDataDir]) async {
  final baseFolder = Directory(dir);

  if (await baseFolder.exists()) {
    baseFolder.list().forEach((element) async {
      if (element is Directory) {
        await element.delete(recursive: true);
      }
    });
  }
}
