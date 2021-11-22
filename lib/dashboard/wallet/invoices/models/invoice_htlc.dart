import 'package:common/common.dart';

import 'custom_records_entry.dart';

enum InvoiceHTLCState { accepted, settled, canceled }

/// Details of an HTLC that paid to an invoice
class InvoiceHTLC {
  /// Short channel id over which the htlc was received.
  final int? chanId;

  /// Index identifying the htlc on the channel.
  final int? htlcIndex;

  /// The amount of the htlc in msat.
  final int? amtMsat;

  /// Block height at which this htlc was accepted.
  final int? acceptHeight;

  /// Time at which this htlc was accepted.
  final DateTime? acceptTime;

  /// Time at which this htlc was settled or canceled.
  final DateTime? resolveTime;

  /// Block height at which this htlc expires.
  final int? expiryHeight;

  /// Current state the htlc is in.
  final InvoiceHTLCState? state;

  /// Custom tlv records.
  final List<CustomRecordsEntry> customRecords;

  /// The total amount of the mpp payment in msat.
  final int? mppTotalAmtMsat;

  InvoiceHTLC({
    this.chanId,
    this.htlcIndex,
    this.amtMsat,
    this.acceptHeight,
    this.acceptTime,
    this.resolveTime,
    this.expiryHeight,
    this.state,
    this.customRecords = const [],
    this.mppTotalAmtMsat,
  });

  InvoiceHTLC.fromJson(Map h)
      : chanId = h['chan_id'],
        htlcIndex = h['htlc_index'],
        amtMsat = h['amt_msat'],
        acceptHeight = h['accept_height'],
        acceptTime = DateTime.fromMillisecondsSinceEpoch(
          h['accept_time'] * 1000 ?? 0,
        ),
        resolveTime = DateTime.fromMillisecondsSinceEpoch(
          h['resolve_time'] * 1000 ?? 0,
        ),
        expiryHeight = h['expiry_height'],
        state = _getState(h['state']),
        customRecords = _getRecords(h['custom_records']),
        mppTotalAmtMsat = h['mpp_total_amt_msat'];
}

List<CustomRecordsEntry> _getRecords(List records) =>
    records.map((r) => CustomRecordsEntry.fromJson(r)).toList();

InvoiceHTLCState? _getState(String state) {
  switch (state) {
    case 'accepted':
      return InvoiceHTLCState.accepted;
    case 'settled':
      return InvoiceHTLCState.settled;
    case 'canceled':
      return InvoiceHTLCState.canceled;
    default:
      BlitzLog().w('Unknown InvoiceHTLCState $state');
  }
}
