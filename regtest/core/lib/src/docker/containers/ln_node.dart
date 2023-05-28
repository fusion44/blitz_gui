import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:common/common.dart' show BtcValue;
import 'package:dio/dio.dart';
import 'package:regtest_core/src/docker/containers/docker_container.dart';

import '../../constants.dart';
import '../../manager.dart';
import '../../models.dart';
import '../../utils.dart';

class LnNode extends DockerContainer {
  late final String pubKey;
  final List<RegtestChannel> channels = [];
  late LnInfo lnInfo;
  final int id;
  final String alias;

  final String btcContainerName;
  late BlitzApiClient _api;
  bool _bootstrapped = false;
  late String? _token;

  LnNode(
    super.containerName,
    super.image,
    this.id,
    this.alias,
    this.btcContainerName,
  ) {
    _api = BlitzApiClient(basePathOverride: 'http://localhost:8825/latest');

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
  String get hostname => containerName;
  String get fullUri => "$pubKey@$hostname:9735";
  String? get token => _token;
  BlitzApiClient get api {
    if (!_bootstrapped) throw Exception("Node $containerName not bootstrapped");

    return _api;
  }

  bool get bootstrapped => _bootstrapped;
  Implementation get implementation => Implementation.empty;

  Future<void> bootstrap() async {
    if (_bootstrapped) {
      throw Exception("Node $containerName already bootstrapped");
    }

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
        'Node $containerName: Exception when calling SystemApi->systemLoginSystemLoginPost',
      );
    }

    Response<LnInfo> lnInfoResp;
    try {
      lnInfoResp =
          await _api.getLightningApi().lightningGetInfoLightningGetInfoGet();

      if (lnInfoResp.statusCode != 200) {
        throw Exception("Failed to bootstrap node $containerName");
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
        'Node $containerName: Exception when calling SystemApi->systemLoginSystemLoginPost',
      );

      logMessage(
        "Unable to bootstrap $containerName with pubkey $pubKey, ${_api.dio.options.baseUrl}",
      );
    }

    logMessage(
      "Bootstrapped $containerName with pubkey $pubKey, ${_api.dio.options.baseUrl}",
    );
  }

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
    int pushAmountSat = 0,
  }) async {
    try {
      final res = await _api
          .getLightningApi()
          .lightningOpenChannelLightningOpenChannelPost(
            localFundingAmount: localFundingAmount,
            nodeURI: to.fullUri,
            pushAmountSat: pushAmountSat,
          );
      return res.data ?? '';
    } catch (e) {
      if (e is DioError) {
        printDioError(e,
            "Error opening channel from $containerName to ${to.containerName}");
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
      await _api.getLightningApi().lightningSendPaymentLightningSendPaymentPost(
            payReq: i.bolt11,
            amountMsat: i.amt,
          );
      return true;
    } catch (e) {
      if (e is DioError) {
        printDioError(e, "Error paying invoice from $containerName}");
      }

      logMessage("$e");
    }

    return false;
  }

  Future<List<RegtestChannel>> fetchChannels([
    bool includeClosed = false,
  ]) async {
    try {
      final res = await _api
          .getLightningApi()
          .lightningListChannelsLightningListChannelsGet(
            includeClosed: includeClosed,
          );
      final data = res.data;
      if (data == null) return [];

      final d = data.toList().map(
        (e) {
          final r = NetworkManager().nodeByPubKey(e.peerPublickey);
          if (r == null) {
            logMessage("Failed to find node for pubkey ${e.peerPublickey}");
            throw StateError(
              "Failed to find node for pubkey ${e.peerPublickey}",
            );
          }

          return RegtestChannel(
            e.channelId ?? "",
            this,
            BtcValue.fromMilliSat(e.balanceLocal ?? 0),
            r,
            BtcValue.fromMilliSat(e.balanceRemote ?? 0),
            channel: e,
          );
        },
      ).toList();

      channels.clear();
      channels.addAll(d);
      return d;
    } catch (e) {
      if (e is DioError) {
        printDioError(e, "Error fetching channels from $containerName");
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
        printDioError(e, "Error sending on-chain from $containerName");
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
        numClosed++;
      } catch (e) {
        print(
            "sweepChannels($containerName): Failed to close channel ${c.id}: $e");
      }
    }

    return numClosed;
  }
}