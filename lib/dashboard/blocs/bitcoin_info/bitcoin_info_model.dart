import '../../../common/utils.dart';

class BitcoinInfo {
  int? version;
  String? subversion;
  bool? networkActive;
  List<Network>? networks;
  int? connections;
  int? connectionsIn;
  int? connectionsOut;
  String? chain;
  int? blocks;
  int? headers;
  double? verificationProgress;
  bool? initialBlockDl;
  int? sizeOnDisk;
  bool? pruned;

  BitcoinInfo({
    this.version,
    this.subversion,
    this.networkActive,
    this.networks,
    this.connections,
    this.connectionsIn,
    this.connectionsOut,
    this.chain,
    this.blocks,
    this.headers,
    this.verificationProgress,
    this.initialBlockDl,
    this.sizeOnDisk,
    this.pruned,
  });

  static BitcoinInfo fromJson(Map<String, dynamic> json) {
    final networks = <Network>[];
    if (json['networks'] != null) {
      json['networks'].forEach((v) {
        networks.add(Network.fromJson(v));
      });
    }

    return BitcoinInfo(
      version: json['version'],
      subversion: json['subversion'],
      networkActive: json['networkactive'],
      networks: networks,
      connections: json['connections'],
      connectionsIn: json['connections_in'],
      connectionsOut: json['connections_out'],
      chain: json['chain'],
      blocks: json['blocks'],
      headers: json['headers'],
      verificationProgress: forceDouble(json['verification_progress']),
      initialBlockDl: json['initialblockdownload'],
      sizeOnDisk: json['size_on_disk'],
      pruned: json['pruned'],
    );
  }
}

class Network {
  final String? name;
  final bool? limited;
  final bool? reachable;
  final String? proxy;
  final bool? proxyRandomizeCreds;

  Network({
    this.name,
    this.limited,
    this.reachable,
    this.proxy,
    this.proxyRandomizeCreds,
  });

  static Network fromJson(Map<String, dynamic> json) {
    return Network(
      name: json['name'],
      limited: json['limited'],
      reachable: json['reachable'],
      proxy: json['proxy'],
      proxyRandomizeCreds: json['proxy_randomize_credentials'],
    );
  }
}
