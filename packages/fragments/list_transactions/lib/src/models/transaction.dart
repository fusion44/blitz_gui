class Transaction {
  final int index;
  final String id;
  final String category;
  final String type;
  final int amount;
  final int timeStamp;
  final String comment;
  final String status;
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
    return Transaction(
      index: json['index'] ?? -1,
      id: json['id'] ?? '',
      category: json['category'] ?? 'unknown',
      type: json['type'] ?? 'unknown',
      amount: json['amount'] ?? 0,
      timeStamp: json['time_stamp'] ?? 0,
      comment: json['comment'] ?? '',
      status: json['status'] ?? 'unknown',
      blockHeight: json['block_height'] ?? 0,
      numConfs: json['num_confs'] ?? 0,
      totalFees: json['total_fees'] ?? 0,
    );
  }
}
