import '../utils.dart';

class BlockData {
  final String hash;
  final int confirmations;
  final int strippedSize;
  final int size;
  final int weight;
  final int height;
  final int version;
  final String versionHex;
  final String merkleRoot;
  final List<String> tx;
  final int time;
  final int medianTime;
  final int nonce;
  final String bits;
  final double difficulty;
  final String chainWork;
  final int nTx;
  final String previousBlockHash;

  BlockData({
    required this.hash,
    required this.confirmations,
    required this.strippedSize,
    required this.size,
    required this.weight,
    required this.height,
    required this.version,
    required this.versionHex,
    required this.merkleRoot,
    required this.tx,
    required this.time,
    required this.medianTime,
    required this.nonce,
    required this.bits,
    required this.difficulty,
    required this.chainWork,
    required this.nTx,
    required this.previousBlockHash,
  });

  static BlockData fromJson(Map<String, dynamic> json) {
    return BlockData(
      hash: forceString(json['hash']),
      confirmations: forceInt(json['confirmations'], defaultValue: -1),
      strippedSize: forceInt(json['strippedsize']),
      size: forceInt(json['size']),
      weight: forceInt(json['weight']),
      height: forceInt(json['height']),
      version: forceInt(json['version']),
      versionHex: forceString(json['versionHex']),
      merkleRoot: forceString(json['merkleroot']),
      tx: json['tx'].cast<String>(),
      time: forceInt(json['time']),
      medianTime: forceInt(json['mediantime']),
      nonce: forceInt(json['nonce']),
      bits: forceString(json['bits']),
      difficulty: forceDouble(json['difficulty']),
      chainWork: forceString(json['chainwork']),
      nTx: forceInt(json['nTx']),
      previousBlockHash: forceString(json['previousblockhash']),
    );
  }
}
