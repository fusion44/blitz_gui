import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

enum TxCategory { onchain, ln }

enum TxType { incoming, outgoing, unknown }

enum TxStatus { unknown, inFlight, succeeded, failed }

@Freezed()
class Transaction with _$Transaction {
  // ignore: unused_element
  const Transaction._(); // Added constructor
  const factory Transaction({
    required int index,
    required String id,
    required TxCategory category,
    required TxType type,
    required double amount,
    required DateTime timeStamp,
    required String comment,
    required TxStatus status,
    @Default(0) int blockHeight,
    @Default(0) int numConfs,
    @Default(0.0) double totalFees,
    @Default(true) bool hasRemainder,
  }) = _Transaction;

  Transaction withIncreasedBlockHeight() =>
      copyWith(blockHeight: blockHeight + 1, numConfs: numConfs + 1);

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

    // all amounts are in millisatoshis => convert to satoshis
    // we display satoshis and msats as the remainder
    double a = json['amount'] != null ? json['amount'] / 1000 : 0.0;
    double f = json['total_fees'] != null ? json['total_fees'] / 1000 : 0.0;

    return Transaction(
      index: json['index'] ?? -1,
      id: json['id'] ?? '',
      category: cat,
      type: type,
      amount: a,
      timeStamp:
          DateTime.fromMillisecondsSinceEpoch(json['time_stamp'] * 1000 ?? 0),
      comment: json['comment'] ?? '',
      status: status,
      blockHeight: json['block_height'] ?? 0,
      numConfs: json['num_confs'] ?? 0,
      totalFees: f,
      hasRemainder: a % 1 != 0,
    );
  }
}
