// ignore_for_file: avoid_print

library utils;

import 'dart:async';
import 'dart:math';
import 'dart:io' show Directory, File, Platform;

import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:english_words/english_words.dart';
import 'package:path/path.dart' as path;

import 'commands/bitcoind.dart';
import 'constants.dart';
import 'manager.dart';
import 'models.dart';

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
        await doMineBlocks(rand.nextInt(6) + 3);

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

String formatAmount(int amount, [Denomination d = Denomination.msats]) {
  if (d == Denomination.btc) {
    final f = NumberFormat("##,##0.00000000", "en").format(amount);
    return "$f BTC";
    // return NumberFormat("##,##0.00000000", "en").format(amount);
  } else if (d == Denomination.sats) {
    return NumberFormat("#,###,###,###,###", "en").format(amount);
  }

  return NumberFormat('#,##0.000', 'en_US').format(amount);
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

String getComposeString() {
  return """
version: "3.7"
services:
  # REDIS
  # ================================
  redis:
    image: redis:7.0.5
    restart: on-failure
    expose:
      - 6379

  # BITCOIND
  # ================================
  bitcoind:
    image: boltz/bitcoin-core:24.0.1
    command: "-regtest -fallbackfee=0.00000253 -zmqpubrawtx=tcp://0.0.0.0:29000 -zmqpubrawblock=tcp://0.0.0.0:29001 -txindex -rpcallowip=0.0.0.0/0 -rpcbind=0.0.0.0 -rpcuser=regtester -rpcpassword=regtester"
    expose:
      - 18443
    ports:
      - 18443:18443
      
  # LND 1
  # ================================
  lnd1:
    depends_on:
      - bitcoind
    image: boltz/lnd:0.15.5-beta
    restart: on-failure
    entrypoint: "sh -c 'sleep 20; lnd --alias=lnd1 --listen=lnd1:9735 --rpclisten=lnd1:10009 --restlisten=lnd1:8081 --bitcoin.active --bitcoin.regtest --bitcoin.node=bitcoind --bitcoind.rpchost=bitcoind --bitcoind.zmqpubrawtx=bitcoind:29000 --bitcoind.zmqpubrawblock=bitcoind:29001 --bitcoind.rpcuser=regtester --bitcoind.rpcpass=regtester --noseedbackup --protocol.wumbo-channels --tlsextraip=127.0.0.1 --tlsextraip=0.0.0.0 --tlsextradomain=localhost --tlsextradomain=lnd1'"
    ports:
      - 8081:8081
      - 10009:10009
    volumes:
      - /tmp/regtest-data/lnd1:/root/.lnd/

  lnd1-blitz:
    depends_on:
      - redis
      - lnd1
    image: blitz_api:latest
    restart: on-failure
    entrypoint: "sh /code/entrypoint.sh"
    ports:
      - 8822:80
    volumes:
      - /tmp/regtest-data:/root/data
    environment:
      REDIS_HOST: redis
      REDIS_PORT: 6379
      REDIS_DB: 0
      LN_BACKEND: lnd1

  # LND 2
  # ================================
  lnd2:
    depends_on:
      - bitcoind
    image: boltz/lnd:0.15.5-beta
    restart: on-failure
    entrypoint: "sh -c 'sleep 20; lnd --alias=lnd2 --listen=lnd2:9735 --rpclisten=lnd2:10009 --restlisten=lnd2:8081 --bitcoin.active --bitcoin.regtest --bitcoin.node=bitcoind --bitcoind.rpchost=bitcoind --bitcoind.zmqpubrawtx=bitcoind:29000 --bitcoind.zmqpubrawblock=bitcoind:29001 --bitcoind.rpcuser=regtester --bitcoind.rpcpass=regtester --noseedbackup --protocol.wumbo-channels --tlsextraip=127.0.0.1 --tlsextraip=0.0.0.0 --tlsextradomain=localhost --tlsextradomain=lnd2'"
    volumes:
      - /tmp/regtest-data/lnd2:/root/.lnd/

  lnd2-blitz:
    depends_on:
      - redis
      - lnd2
    image: blitz_api:latest
    restart: on-failure
    entrypoint: "sh /code/entrypoint.sh"
    ports:
      - 8823:80
    volumes:
      - /tmp/regtest-data:/root/data
    environment:
      REDIS_HOST: redis
      REDIS_PORT: 6379
      REDIS_DB: 1
      LN_BACKEND: lnd2

  # LND 3
  # ================================
  lnd3:
    depends_on:
      - bitcoind
    image: boltz/lnd:0.15.5-beta
    restart: on-failure
    entrypoint: "sh -c 'sleep 20; lnd --alias=lnd3 --listen=lnd3:9735 --rpclisten=lnd3:10009 --restlisten=lnd3:8081 --bitcoin.active --bitcoin.regtest --bitcoin.node=bitcoind --bitcoind.rpchost=bitcoind --bitcoind.zmqpubrawtx=bitcoind:29000 --bitcoind.zmqpubrawblock=bitcoind:29001 --bitcoind.rpcuser=regtester --bitcoind.rpcpass=regtester --noseedbackup --protocol.wumbo-channels --tlsextraip=127.0.0.1 --tlsextraip=0.0.0.0 --tlsextradomain=localhost --tlsextradomain=lnd3'"
    volumes:
      - /tmp/regtest-data/lnd3:/root/.lnd/

  lnd3-blitz:
    depends_on:
      - redis
      - lnd3
    image: blitz_api:latest
    restart: on-failure
    entrypoint: "sh /code/entrypoint.sh"
    ports:
      - 8824:80
    volumes:
      - /tmp/regtest-data:/root/data
    environment:
      REDIS_HOST: redis
      REDIS_PORT: 6379
      REDIS_DB: 2
      LN_BACKEND: lnd3

  # CLN 1
  # ================================
  cln1:
    depends_on:
      - bitcoind
    image: cln:v23.02.2
    entrypoint: "sh -c 'sleep 15 && lightningd --alias cln1 --large-channels --network regtest --bind-addr=0.0.0.0:9735 --bitcoin-rpcconnect=bitcoind --bitcoin-rpcport=18443 --bitcoin-rpcuser=regtester --bitcoin-rpcpassword=regtester --grpc-port=11109'"
    ports:
      - 11109:11109
    volumes:
      - /tmp/regtest-data/cln1:/root/.lightning/
    environment:
      RUST_BACKTRACE: 1

  cln1-blitz:
    depends_on:
      - redis
      - cln1
    image: blitz_api:latest
    restart: on-failure
    entrypoint: "sh /code/entrypoint.sh"
    ports:
      - 8825:80
    volumes:
      - /tmp/regtest-data:/root/data
    environment:
      REDIS_HOST: redis
      REDIS_PORT: 6379
      REDIS_DB: 3
      LN_BACKEND: cln1

  # CLN 2
  # ================================
  cln2:
    depends_on:
      - bitcoind
    image: cln:v23.02.2
    entrypoint: "sh -c 'sleep 15 && lightningd --alias cln2 --large-channels --network regtest --bind-addr=0.0.0.0:9735 --bitcoin-rpcconnect=bitcoind --bitcoin-rpcport=18443 --bitcoin-rpcuser=regtester --bitcoin-rpcpassword=regtester --grpc-port=11109'"
    volumes:
      - /tmp/regtest-data/cln2:/root/.lightning/

  cln2-blitz:
    depends_on:
      - redis
      - cln2
    image: blitz_api:latest
    restart: on-failure
    entrypoint: "sh /code/entrypoint.sh"
    ports:
      - 8826:80
    volumes:
      - /tmp/regtest-data:/root/data
    environment:
      REDIS_HOST: redis
      REDIS_PORT: 6379
      REDIS_DB: 4
      LN_BACKEND: cln2

volumes:
  regtest-data:
  
""";
}
