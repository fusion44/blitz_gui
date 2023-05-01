// ignore_for_file: avoid_print

import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:dio/dio.dart';

import 'constants.dart';
import 'manager.dart';
import 'model_extensions.dart';
import 'utils.dart';

export 'btc_value.dart';

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

      print("${node.id} ${diff > 0 ? '+' : ''}$diff sat");
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

class LnNode {
  NodeId id;
  String pubKey = '';
  Implementation implementation = Implementation.empty;
  bool singleChild = false;
  bool multiParent = false;
  List<RegtestChannel> channels = [];
  late BlitzApiClient _api;
  String? _token;
  bool _bootstrapped = false;
  late LnInfo lnInfo;

  LnNode([this.id = NodeId.empty]) {
    if (id == NodeId.cln1) {
      implementation = Implementation.cln;
      _api = BlitzApiClient(basePathOverride: 'http://localhost:8825/latest');
    } else if (id == NodeId.cln2) {
      implementation = Implementation.cln;
      _api = BlitzApiClient(basePathOverride: 'http://localhost:8826/latest');
    } else if (id == NodeId.lnd1) {
      implementation = Implementation.lnd;
      _api = BlitzApiClient(basePathOverride: 'http://localhost:8822/latest');
    } else if (id == NodeId.lnd2) {
      implementation = Implementation.lnd;
      _api = BlitzApiClient(basePathOverride: 'http://localhost:8823/latest');
    } else if (id == NodeId.lnd3) {
      implementation = Implementation.lnd;
      _api = BlitzApiClient(basePathOverride: 'http://localhost:8824/latest');
    } else if (id == Implementation.empty) {
      implementation = Implementation.empty;
      _api = BlitzApiClient();
    } else {
      throw Exception("Unknown node ref: $id");
    }

    _api.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) {
          if (_token != null && _token!.isNotEmpty) {
            options.headers["AUTHORIZATION"] = _token;
          }
          handler.next(options);
        },
      ),
    );
  }

  String get hostname => id.name;
  String get fullUri => "$pubKey@$hostname:9735";
  String? get token => _token;
  BlitzApiClient get api {
    if (!_bootstrapped) throw Exception("Node $id not bootstrapped");

    return _api;
  }

  Future<void> bootstrap() async {
    if (_bootstrapped) throw Exception("Node $id already bootstrapped");

    final api = _api.getSystemApi();
    final builder = LoginInputBuilder()..password = "12345678";

    try {
      final response = await api.systemLoginSystemLoginPost(
        loginInput: builder.build(),
      );

      final data = response.data;
      if (data == null || data.value is! String) {
        throw StateError("Login response data was null");
      }

      _token = "Bearer ${data.value.toString()}";
    } on DioError catch (e) {
      printDioError(
        e,
        'Node $id: Exception when calling SystemApi->systemLoginSystemLoginPost',
      );
    }

    Response<LnInfo> lnInfoResp;
    try {
      lnInfoResp =
          await _api.getLightningApi().lightningGetInfoLightningGetInfoGet();

      if (lnInfoResp.statusCode != 200) {
        throw Exception("Failed to bootstrap node $id");
      }

      if (lnInfoResp.data!.identityPubkey != null) {
        pubKey = lnInfoResp.data?.identityPubkey ?? "";
      }

      lnInfo = lnInfoResp.data!;
      await fetchChannels();
      _bootstrapped = true;
    } on DioError catch (e) {
      printDioError(
        e,
        'Node $id: Exception when calling SystemApi->systemLoginSystemLoginPost',
      );

      logMessage(
        "Unable to bootstrap $id with pubkey $pubKey, ${_api.dio.options.baseUrl}",
      );
    }

    logMessage(
      "Bootstrapped $id with pubkey $pubKey, ${_api.dio.options.baseUrl}",
    );
  }

  bool get isCln => implementation == Implementation.cln;
  bool get isLnd => implementation == Implementation.lnd;

  Future<String> genInvoice(GenInvoiceDialogData i) async {
    final resp =
        await _api.getLightningApi().lightningAddInvoiceLightningAddInvoicePost(
              valueMsat: i.mSat,
              memo: i.msg,
            );

    if (resp.data == null) {
      logMessage('Error generating invoice: ${resp.statusMessage}');
      return '';
    }

    return resp.data!.paymentRequest ?? '';
  }

  Future<WalletBalance> walletBalance() async {
    try {
      final resp = await _api
          .getLightningApi()
          .lightningGetBalanceLightningGetBalanceGet();

      final d = resp.data;
      if (resp.statusCode == 200 && d != null) return d;

      throw Exception(
        "Failed to get wallet balance, status code: ${resp.statusCode}, ${resp.statusMessage}",
      );
    } catch (e) {
      throw Exception("Failed to get wallet balance: $e");
    }
  }

  Future<String> newAddress() async {
    try {
      final builder = NewAddressInputBuilder()..type = OnchainAddressType.p2wkh;

      final resp = await _api
          .getLightningApi()
          .lightningNewAddressLightningNewAddressPost(
              newAddressInput: builder.build());

      final d = resp.data;
      if (resp.statusCode == 200 && d != null) return d;

      throw Exception(
        "Failed to get new address, status code: ${resp.statusCode}, ${resp.statusMessage}",
      );
    } catch (e) {
      throw Exception("Failed to get new address: $e");
    }
  }

  Future<String> openChannel(
    LnNode to, {
    int localFundingAmount = defaultChannelSize,
    int pushAmountMsat = 0,
  }) async {
    try {
      final res = await _api
          .getLightningApi()
          .lightningOpenChannelLightningOpenChannelPost(
            localFundingAmount: localFundingAmount,
            nodeURI: to.fullUri,
            pushAmountSat: (defaultChannelSize ~/ 2),
          );
      return res.data ?? '';
    } catch (e) {
      if (e is DioError) {
        printDioError(e, "Error opening channel from $id to ${to.id}");
      }

      logMessage("$e");
    }

    return '';
  }

  Future<void> closeChannel(RegtestChannel c) async {
    try {
      final res = await _api
          .getLightningApi()
          .lightningCloseChannelLightningCloseChannelPost(
            channelId: c.id,
            forceClose: false,
          );
      logMessage(
        "Closed channel ${c.id} from ${c.from.id} to ${c.to.id}, txid: $res",
      );
    } catch (e) {
      if (e is! DioError) {
        logMessage("Unknown error: $e");
      }

      final error = e as DioError;

      Response? eResponse;
      if (error.response != null) {
        eResponse = error.response!;
      }

      dynamic detail;
      if (eResponse != null && eResponse.data is Map) {
        detail = eResponse.data["detail"];
      }

      if (detail != null &&
          detail is String &&
          detail.contains("Short channel ID not active")) {
        logMessage("Ignoring message: $detail");
        return;
      }

      printDioError(
        e,
        "Error closing channel ${c.id} from ${c.from.id}  to ${c.to.id}",
      );
    }
  }

  Future<bool> payInvoice(PayInvoiceData i) async {
    try {
      final res = await _api
          .getLightningApi()
          .lightningSendPaymentLightningSendPaymentPost(
            payReq: i.bolt11,
            amountMsat: i.amt,
          );
      return true;
    } catch (e) {
      if (e is DioError) {
        printDioError(e, "Error paying invoice from $id}");
      }

      logMessage("$e");
    }

    return false;
  }

  Future<List<RegtestChannel>> fetchChannels() async {
    try {
      final res = await _api
          .getLightningApi()
          .lightningListChannelsLightningListChannelsGet();
      final data = res.data;
      if (data == null) return [];

      final d = data.toList().map(
        (e) {
          final r = NetworkManager().nodeByPubKey(e.peerPublickey!);
          if (r == null) {
            logMessage("Failed to find node for pubkey ${e.peerPublickey}");
            throw StateError(
              "Failed to find node for pubkey ${e.peerPublickey}",
            );
          }

          return RegtestChannel(
            e.channelId!,
            this,
            e.balanceLocal!,
            r,
            e.balanceRemote!,
            channel: e,
          );
        },
      ).toList();

      channels = d;
      return d;
    } catch (e) {
      if (e is DioError) {
        printDioError(e, "Error fetching channels from $id");
      }

      logMessage("$e");
    }

    return [];
  }

  Future<SendCoinsResponse?> sendOnChain(
    int numSats,
    String addr, [
    bool sendAll = false,
  ]) async {
    try {
      final builder = SendCoinsInputBuilder();
      builder.address = addr;
      builder.amount = numSats;
      builder.sendAll = sendAll;

      final res = await _api
          .getLightningApi()
          .lightningSendCoinsLightningSendCoinsPost(
              sendCoinsInput: builder.build());

      return res.data;
    } catch (e) {
      if (e is DioError) {
        printDioError(e, "Error sending on-chain from $id");
      }

      logMessage("$e");
    }

    return null;
  }

  Future<int> sweepChannels() async {
    await fetchChannels();

    var numClosed = 0;
    for (var c in channels) {
      try {
        await c.from.closeChannel(c);
      } catch (e) {
        print("sweepChannels($id): Failed to close channel ${c.id}: $e");
      }
    }

    return numClosed;
  }
}

class RegtestChannel {
  final String id;
  final LnNode from;
  final int ourFunds;
  final LnNode to;
  final int otherFunds;
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
        ourFunds = clnParseMSatOrZero(json["our_amount_msat"]),
        otherFunds = clnParseMSatOrZero(json["amount_msat"]) -
            clnParseMSatOrZero(json["our_amount_msat"]);

  RegtestChannel.fromLND(
    this.from,
    Map<String, LnNode> nodes,
    Map<String, dynamic> json, {
    required this.channel,
  })  : id = json["channel_point"],
        to = nodes[json["remote_pubkey"]]!,
        ourFunds = validIntOrZero(json["local_balance"]),
        otherFunds = validIntOrZero(json["remote_balance"]);

  @override
  String toString() => "Channel from ${from.id} to ${to.id}";
}

class MineBlockData {
  final int numBlocks;
  final bool delay;
  final int from;
  final int to;

  MineBlockData(this.numBlocks, this.delay, this.from, this.to);

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
