import 'package:common/common.dart';

class BitcoinInfo {
  final int blocks;
  final int headers;
  final double verificationProgress;
  final double difficulty;
  final int sizeOnDisk;
  final List<BitcoinNetwork>? networks;
  final int version;
  final String subversion;
  final int connections;
  final int connectionsIn;
  final int connectionsOut;

  BitcoinInfo({
    required this.version,
    required this.subversion,
    required this.networks,
    required this.connections,
    required this.connectionsIn,
    required this.connectionsOut,
    required this.blocks,
    required this.headers,
    required this.verificationProgress,
    required this.sizeOnDisk,
    required this.difficulty,
  });

  static BitcoinInfo fromJson(Map<String, dynamic> json) {
    final networks = <BitcoinNetwork>[];
    if (json['networks'] != null) {
      json['networks'].forEach((v) {
        networks.add(BitcoinNetwork.fromJson(v));
      });
    }

    int connectionsIn = forceInt(json['connections_in']);
    int connectionsOut = forceInt(json['connections_out']);

    int connections = forceInt(json['connections'], defaultValue: -1);
    if (connections == -1) {
      connections = connectionsIn + connectionsOut;
    }

    return BitcoinInfo(
      version: forceInt(json['version']),
      subversion: forceString(json['subversion']),
      networks: networks,
      connections: connections,
      connectionsIn: connectionsIn,
      connectionsOut: connectionsOut,
      blocks: forceInt(json['blocks']),
      headers: forceInt(json['headers']),
      verificationProgress: forceDouble(json['verification_progress']),
      sizeOnDisk: forceInt(json['size_on_disk']),
      difficulty: forceDouble(json['difficulty']),
    );
  }
}

class BitcoinNetwork {
  final String name;
  final bool limited;
  final bool reachable;
  final String proxy;
  final bool proxyRandomizeCreds;

  BitcoinNetwork({
    required this.name,
    required this.limited,
    required this.reachable,
    required this.proxy,
    required this.proxyRandomizeCreds,
  });

  static BitcoinNetwork fromJson(Map<String, dynamic> json) {
    return BitcoinNetwork(
      name: forceString(json['name']),
      limited: forceBool(json['limited']),
      reachable: forceBool(json['reachable']),
      proxy: forceString(json['proxy']),
      proxyRandomizeCreds: forceBool(json['proxy_randomize_credentials']),
    );
  }
}
