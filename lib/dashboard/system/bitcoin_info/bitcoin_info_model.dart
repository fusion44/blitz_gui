import 'package:common/common.dart';

class BitcoinInfo {
  int? blocks;
  int? headers;
  double? verificationProgress;
  double? difficulty;
  int? sizeOnDisk;
  List<Network>? networks;
  int? version;
  String? subversion;
  int? connections;
  int? connectionsIn;
  int? connectionsOut;

  BitcoinInfo({
    this.version,
    this.subversion,
    this.networks,
    this.connections,
    this.connectionsIn,
    this.connectionsOut,
    this.blocks,
    this.headers,
    this.verificationProgress,
    this.sizeOnDisk,
    this.difficulty,
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
      networks: networks,
      connections: json['connections'] ??
          json['connections_in'] + json['connections_out'],
      connectionsIn: json['connections_in'],
      connectionsOut: json['connections_out'],
      blocks: json['blocks'],
      headers: json['headers'],
      verificationProgress: forceDouble(json['verification_progress']),
      sizeOnDisk: json['size_on_disk'],
      difficulty: forceDouble(json['difficulty']),
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
