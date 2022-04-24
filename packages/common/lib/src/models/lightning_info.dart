class LightningInfo {
  final String implementation;
  final String version;
  final String commitHash;
  final String identityPubkey;
  final String alias;
  final String color;
  final int numPendingChannels;
  final int numActiveChannels;
  final int numInactiveChannels;
  final int numPeers;
  final int blockHeight;
  final String blockHash;
  final int bestHeaderTimestamp;
  final bool syncedToChain;
  final bool syncedToGraph;
  final List<Chain> chains;
  final List<String> uris;
  final List<Feature> features;

  const LightningInfo({
    this.implementation = '',
    this.version = '',
    this.commitHash = '',
    this.identityPubkey = '',
    this.alias = '',
    this.color = '',
    this.numPendingChannels = 0,
    this.numActiveChannels = 0,
    this.numInactiveChannels = 0,
    this.numPeers = 0,
    this.blockHeight = 0,
    this.blockHash = '',
    this.bestHeaderTimestamp = 0,
    this.syncedToChain = false,
    this.syncedToGraph = false,
    this.chains = const [],
    this.uris = const [],
    this.features = const [],
  });

  static LightningInfo fromJson(dynamic json) {
    final chains = <Chain>[];
    if (json['chains'] != null) {
      json['chains'].forEach((v) {
        chains.add(Chain.fromJson(v));
      });
    }
    final features = <Feature>[];

    if (json['features'] != null) {
      json['features'].forEach((v) {
        features.add(Feature.fromJson(v));
      });
    }

    return LightningInfo(
      implementation: json['implementation'],
      version: json['version'],
      commitHash: json['commit_hash'],
      identityPubkey: json['identity_pubkey'],
      alias: json['alias'],
      color: json['color'],
      numPendingChannels: json['num_pending_channels'],
      numActiveChannels: json['num_active_channels'],
      numInactiveChannels: json['num_inactive_channels'],
      numPeers: json['num_peers'],
      blockHeight: json['block_height'],
      blockHash: json['block_hash'],
      bestHeaderTimestamp: json['best_header_timestamp'],
      syncedToChain: json['synced_to_chain'],
      syncedToGraph: json['synced_to_graph'],
      chains: chains,
      uris: json['uris'].cast<String>(),
      features: features,
    );
  }
}

class Chain {
  final String? chain;
  final String? network;

  Chain(this.chain, this.network);

  Chain.fromJson(Map<String, dynamic> json)
      : chain = json['chain'],
        network = json['network'];
}

class Feature {
  final int? key;
  final Value? value;

  Feature(this.key, this.value);

  Feature.fromJson(dynamic json)
      : key = json['key'],
        value = Value.fromJson(json['value']);
}

class Value {
  final String name;
  final bool isRequired;
  final bool isKnown;

  Value(this.name, this.isRequired, this.isKnown);

  Value.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        isRequired = json['is_required'],
        isKnown = json['is_known'];
}
