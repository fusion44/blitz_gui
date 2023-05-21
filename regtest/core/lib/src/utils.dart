// ignore_for_file: avoid_print

library utils;

import 'dart:async';
import 'dart:io' show Platform;
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
        final addr = await d.node.newAddress();
        cParty.sendOnChain(numSats, addr);
      } catch (e) {
        logMessage(e.toString());
      }
    } else if (i == 3) {
      try {
        final addr = await cParty.newAddress();
        await d.node.sendOnChain(numSats, addr);
      } catch (e) {
        logMessage(e.toString());
      }
    }

    if (i == 2 || i == 3) {
      try {
        await NetworkManager().btcc.mineBlocks(rand.nextInt(6) + 3);

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
  final nodes = NetworkManager().nodeList;
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
