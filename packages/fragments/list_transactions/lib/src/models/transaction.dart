enum TxCategory { onchain, ln }
enum TxType { incoming, outgoing, unknown }
enum TxStatus { unknown, inFlight, succeeded, failed }

class Transaction {
  final int index;
  final String id;
  final TxCategory category;
  final TxType type;
  final int amount;
  final DateTime timeStamp;
  final String comment;
  final TxStatus status;
  final int? blockHeight;
  final int? numConfs;
  final int? totalFees;

  Transaction({
    required this.index,
    required this.id,
    required this.category,
    required this.type,
    required this.amount,
    required this.timeStamp,
    required this.comment,
    required this.status,
    required this.blockHeight,
    required this.numConfs,
    required this.totalFees,
  });

  static Transaction fromJson(Map<String, dynamic> json) {
    final cat = json['category'] == 'ln' ? TxCategory.ln : TxCategory.onchain;

    var type = TxType.unknown;
    if (json['type'] == 'send') {
      type = TxType.outgoing;
    } else if (json['type'] == 'receive') {
      type = TxType.incoming;
    }

    var status = TxStatus.unknown;
    if (json['status'] == 'in_flight') {
      status = TxStatus.inFlight;
    } else if (json['status'] == 'succeeded') {
      status = TxStatus.succeeded;
    } else if (json['status'] == 'failed') {
      status = TxStatus.failed;
    }

    return Transaction(
      index: json['index'] ?? -1,
      id: json['id'] ?? '',
      category: cat,
      type: type,
      amount: json['amount'] ?? 0,
      timeStamp:
          DateTime.fromMillisecondsSinceEpoch(json['time_stamp'] * 1000 ?? 0),
      comment: json['comment'] ?? '',
      status: status,
      blockHeight: json['block_height'] ?? 0,
      numConfs: json['num_confs'] ?? 0,
      totalFees: json['total_fees'] ?? 0,
    );
  }
}
