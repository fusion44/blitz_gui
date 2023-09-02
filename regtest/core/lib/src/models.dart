// ignore_for_file: avoid_print

import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:common/common.dart' show BtcValue;

import '../core.dart';

class WalletBalances {
  Map<LnNode, WalletBalance> balances = {};

  WalletBalances(this.balances);

  int get total {
    var total = 0;
    for (final value in balances.values) {
      total += value.total;
    }
    return total;
  }

  bool areAllHigherThan(WalletBalances other, {bool confirmedOnly = false}) {
    for (final entry in other.balances.entries) {
      final key = entry.key;

      final ourBalance = balances[key]!;
      final otherBalance = other.balances[key]!;
      final isHigher = ourBalance.isHigherThan(
        otherBalance,
        confirmedOnly: confirmedOnly,
      );

      if (!isHigher) return false;
    }

    return true;
  }

  void printComparison(WalletBalances others, {bool confirmedOnly = false}) {
    final ours = this;
    if (ours.balances.length != others.balances.length) {
      throw Exception("Can't compare different number of nodes");
    }

    for (final entry in others.balances.entries) {
      final node = entry.key;
      final balance = entry.value;

      int diff = balance.total - ours.balances[node]!.total;
      if (confirmedOnly) {
        diff = balance.confirmed - ours.balances[node]!.confirmed;
      }

      print("${node.opts.name} ${diff > 0 ? '+' : ''}$diff sat");
    }
  }

  // returns true if all of the balances are empty
  bool get areEmpty {
    for (final balance in balances.values) {
      if (balance.isNotEmpty) return false;
    }

    return true;
  }

  // returns true if any of the balances is not empty
  bool get areNotEmpty {
    for (final balance in balances.values) {
      if (balance.isEmpty) return false;
    }

    return true;
  }

  bool get haveOnchainFunds {
    for (final balance in balances.values) {
      if (balance.hasOnchainFunds) return true;
    }

    return false;
  }

  bool get haveUnconfirmedFunds {
    for (final balance in balances.values) {
      if (balance.hasUnconfirmedFunds) return true;
    }

    return false;
  }

  bool get haveNoOnchainFunds {
    for (final balance in balances.values) {
      if (balance.hasOnchainFunds) return false;
    }

    return true;
  }

  bool get haveChannelFunds {
    for (final balance in balances.values) {
      if (balance.hasChannelFunds) return true;
    }

    return false;
  }

  bool get haveNoChannelFunds {
    for (final balance in balances.values) {
      if (balance.hasChannelFunds) return false;
    }

    return true;
  }
}

class RegtestChannel {
  final String id;
  final LnNode from;
  final BtcValue ourFunds;
  final LnNode to;
  final BtcValue otherFunds;
  final Channel channel;

  RegtestChannel(
    this.id,
    this.from,
    this.ourFunds,
    this.to,
    this.otherFunds, {
    required this.channel,
  });

  RegtestChannel.fromCLN(
    this.from,
    Map<String, LnNode> nodes,
    Map<String, dynamic> json, {
    required this.channel,
  })  : id = json["id"],
        to = nodes[json["peer_id"]]!,
        ourFunds = BtcValue.fromMilliSat(
          clnParseMSatOrZero(json["our_amount_msat"]),
        ),
        otherFunds = BtcValue.fromMilliSat(
          clnParseMSatOrZero(json["amount_msat"]) -
              clnParseMSatOrZero(json["our_amount_msat"]),
        );

  RegtestChannel.fromLND(
    this.from,
    Map<String, LnNode> nodes,
    Map<String, dynamic> json, {
    required this.channel,
  })  : id = json["channel_point"],
        to = nodes[json["remote_pubkey"]]!,
        ourFunds = BtcValue.fromSats(validIntOrZero(json["local_balance"])),
        otherFunds = BtcValue.fromSats(validIntOrZero(json["remote_balance"]));

  @override
  String toString() => "Channel from ${from.opts.name} to ${to.opts.name}";
}

class MineBlockData {
  final int numBlocks;
  final bool delay;
  final int from;
  final int to;

  MineBlockData(
    this.numBlocks, [
    this.delay = false,
    this.from = 0,
    this.to = 0,
  ]);

  MineBlockData.empty()
      : delay = false,
        from = 0,
        to = 0,
        numBlocks = 5;

  @override
  String toString() =>
      "MineBlockData{blocks: $numBlocks delay: $delay from $from to $to}";
}

class PayInvoiceData {
  final String bolt11;
  final int? amt;

  PayInvoiceData(this.bolt11, [this.amt]);

  @override
  String toString() => "PayInvoiceData{bolt11: $bolt11, amt: $amt}";
}

class PayInvoiceResult {
  final bool success;
  final String error;

  PayInvoiceResult(this.success, this.error);

  @override
  String toString() =>
      "PayInvoiceResult{success: $success, processOut: $error}";
}

class OpenChannelDialogData {
  final int numSats;
  final int numPushSats;
  final bool autoMine;
  final LnNode? destination;
  final bool delayBroadcast;
  final int broadcastDelay;
  final int mineDelay;
  final int numBlocks;

  OpenChannelDialogData({
    this.numSats = 5000000,
    this.numPushSats = 0,
    this.autoMine = false,
    this.destination,
    this.delayBroadcast = false,
    this.broadcastDelay = 0,
    this.mineDelay = 0,
    this.numBlocks = 3,
  });

  @override
  String toString() =>
      "OpenChannelDialogData{numSats: $numSats, numPushSats: $numPushSats, autoMine: $autoMine, destination: $destination}";

  factory OpenChannelDialogData.empty() => OpenChannelDialogData(numSats: 0);
}

class SendOnchainDialogData {
  final int numSats;
  final String address;
  final bool delayBroadcast;
  final int broadcastDelay;
  final bool autoMine;
  final int mineDelay;
  final int numBlocks;
  final LnNode? destination;
  final bool sendAll;

  SendOnchainDialogData({
    required this.numSats,
    required this.address,
    this.delayBroadcast = false,
    this.broadcastDelay = 0,
    this.autoMine = false,
    this.mineDelay = 0,
    this.numBlocks = 5,
    this.destination,
    this.sendAll = false,
  });

  @override
  String toString() =>
      "SendOnchainDialogData{address: $address, delayBroadcast: $delayBroadcast, broadcastDelay: $broadcastDelay, autoMine: $autoMine, mineDelay: $mineDelay, address: $address}";

  SendOnchainDialogData.empty()
      : numSats = 0,
        address = '',
        autoMine = false,
        mineDelay = 0,
        delayBroadcast = false,
        broadcastDelay = 0,
        numBlocks = 5,
        destination = null,
        sendAll = false;
}

class SendOnchainResult {
  final bool success;
  final String processOut;
  final SendOnchainDialogData data;

  SendOnchainResult(this.success, this.processOut, this.data);

  @override
  String toString() =>
      "SendOnchainResult{success: $success, processOut: $processOut, request: $data}";
}

class GenInvoiceDialogData {
  final LnNode node;
  final String msg;
  final int mSat;
  final LnNode? payer;
  final int payAmt;
  final int payDelay;

  GenInvoiceDialogData({
    required this.node,
    this.mSat = 10000,
    this.msg = "",
    this.payer,
    this.payAmt = 0,
    this.payDelay = 0,
  });

  GenInvoiceDialogData.empty(this.node)
      : mSat = 10000,
        msg = "",
        payer = null,
        payAmt = 0,
        payDelay = 0;

  @override
  String toString() =>
      "GenInvoiceData{node: $node, mSat: $mSat, msg: $msg, payDelay $payDelay, payer $payer, payAmt $payAmt}";
}

class AddJunkTxDlgData {
  final LnNode node;
  final int numInvoices;
  final int numPayments;
  final int numOnchainTx;
  final int satsRangeLower;
  final int satsRangeUpper;
  final bool delay;
  final int delayLower;
  final int delayUpper;

  AddJunkTxDlgData({
    required this.node,
    this.numInvoices = 0,
    this.numPayments = 0,
    this.numOnchainTx = 0,
    this.satsRangeLower = 10000,
    this.satsRangeUpper = 1000000,
    this.delay = false,
    this.delayLower = 0,
    this.delayUpper = 0,
  });

  AddJunkTxDlgData.empty(this.node)
      : numInvoices = 0,
        numPayments = 0,
        numOnchainTx = 0,
        satsRangeLower = 10000,
        satsRangeUpper = 1000000,
        delay = false,
        delayLower = 0,
        delayUpper = 0;

  @override
  String toString() =>
      "AddJunkTxDlgData{invoices: $numInvoices, pays:$numPayments, delay: $delay}";
}
