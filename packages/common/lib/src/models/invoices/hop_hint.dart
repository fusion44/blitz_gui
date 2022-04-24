class HopHint {
  // The public key of the node at the start of the channel.
  final String? nodeId;

  //The unique identifier of the channel.
  final int? chanId;

  // The base fee of the channel denominated in millisatoshis.
  final int? feeBaseMsat;

  //The fee rate of the channel for sending one satoshi across it denominated in millionths of a satoshi.
  final int? feeProportionalMillionths;

  // The time-lock delta of the channel.
  final int? cltvExpiryDelta;

  HopHint({
    this.nodeId,
    this.chanId,
    this.feeBaseMsat,
    this.feeProportionalMillionths,
    this.cltvExpiryDelta,
  });

  HopHint.fromJson(Map json)
      : nodeId = json['node_id'],
        chanId = json['chan_id'],
        feeBaseMsat = json['fee_base_msat'],
        feeProportionalMillionths = json['fee_proportional_millionths'],
        cltvExpiryDelta = json['cltv_expiry_delta'];
}
