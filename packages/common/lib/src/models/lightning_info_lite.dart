class LightningInfoLite {
  final String? implementation;
  final String? version;
  final int? numPendingChannels;
  final int? numActiveChannels;
  final int? numInactiveChannels;
  final int? numPeers;
  final int? blockHeight;
  final bool? syncedToChain;
  final bool? syncedToGraph;

  const LightningInfoLite({
    this.implementation = '',
    this.version = '',
    this.numPendingChannels = 0,
    this.numActiveChannels = 0,
    this.numInactiveChannels = 0,
    this.numPeers = 0,
    this.blockHeight = 0,
    this.syncedToChain = false,
    this.syncedToGraph = false,
  });

  static LightningInfoLite fromJson(dynamic json) {
    return LightningInfoLite(
      implementation: json['implementation'],
      version: json['version'],
      numPendingChannels: json['num_pending_channels'],
      numActiveChannels: json['num_active_channels'],
      numInactiveChannels: json['num_inactive_channels'],
      numPeers: json['num_peers'],
      blockHeight: json['block_height'],
      syncedToChain: json['synced_to_chain'],
      syncedToGraph: json['synced_to_graph'],
    );
  }
}
