import '../models.dart';
import 'hop_hint.dart';
import 'invoice_htlc.dart';

enum InvoiceState { open, settled, canceled, accepted }

class Invoice {
  /// An optional memo to attach along with the invoice. Used for
  /// record keeping purposes for the invoice's creator, and will
  /// also be set in the description field of the encoded payment
  /// request if the description_hash field is not being used.
  final String? memo;

  /// The hex-encoded preimage (32 byte) which will allow settling
  /// an incoming HTLC payable to this preimage. When using REST,
  /// this field must be encoded as base64.
  final String? preimage;

  /// The hash of the preimage. When using REST, this field must be
  /// encoded as base64.
  final String? hash;

  /// The value of this invoice in satoshis The fields value and
  /// value_msat are mutually exclusive.
  final int? value;

  /// The value of this invoice in millisatoshis The fields value
  /// and value_msat are mutually exclusive.
  final int? valuemSat;

  /// When this invoice was created
  final DateTime? creationDate;

  /// When this invoice was settled
  final DateTime? settleDate;

  /// A bare-bones invoice for a payment within the Lightning Network.
  /// With the details of the invoice, the sender has all the data
  /// necessary to send a payment to the recipient.
  final String? paymentRequest;

  /// Hash (SHA-256) of a description of the payment. Used if the
  /// description of payment (memo) is too long to naturally fit
  /// within the description field of an encoded payment request.
  final String? descriptionHash;

  /// Payment request expiry time in seconds. Default is 3600 (1 hour).
  final int? expiry;

  /// Fallback on-chain address.
  final String? fallbackAddr;

  /// Delta to use for the time-lock of the CLTV extended to the final hop.
  final int? cltvExpiry;

  /// Route hints that can each be individually used to assist in reaching
  /// the invoice's destination.
  final List<List<HopHint>?>? routeHints;

  /// Whether this invoice should include routing hints for private channels.
  final bool? private;

  /// 	The "add" index of this invoice. Each newly created invoice will
  /// increment this index making it monotonically increasing. Callers
  /// to the SubscribeInvoices call can use this to instantly get notified
  /// of all added invoices with an add_index greater than this one.
  final int? addIndex;

  /// The "settle" index of this invoice. Each newly settled invoice will
  /// increment this index making it monotonically increasing. Callers to
  /// the SubscribeInvoices call can use this to instantly get notified of
  /// all settled invoices with an settle_index greater than this one.
  final int? settleIndex;

  /// 	The amount that was accepted for this invoice, in millisatoshis.
  /// This will ONLY be set if this invoice has been settled. We provide
  /// this field as if the invoice was created with a zero value, then we
  /// need to record what amount was ultimately accepted. Additionally,
  /// it's possible that the sender paid MORE that was specified in the
  /// original invoice. So we'll record that here as well.
  final int? amtPaidmSat;

  /// The state the invoice is in.
  final InvoiceState? state;

  /// List of HTLCs paying to this invoice. EXPERIMENTAL
  final List<InvoiceHTLC>? htlcs;

  /// List of features advertised on the invoice.
  final List<Feature>? features;

  /// Indicates if this invoice was a spontaneous payment that arrived
  /// via keysend.
  final bool? isKeySend;

  const Invoice({
    this.memo,
    this.preimage,
    this.hash,
    this.value,
    this.valuemSat,
    this.creationDate,
    this.settleDate,
    this.paymentRequest,
    this.descriptionHash,
    this.expiry,
    this.fallbackAddr,
    this.cltvExpiry,
    this.routeHints,
    this.private,
    this.addIndex,
    this.settleIndex,
    this.amtPaidmSat,
    this.state,
    this.htlcs,
    this.features,
    this.isKeySend,
  });

  static Invoice fromJson(Map json) {
    InvoiceState state;
    switch (json['state']) {
      case 'accepted':
        state = InvoiceState.accepted;
        break;
      case 'canceled':
        state = InvoiceState.canceled;
        break;
      case 'settled':
        state = InvoiceState.settled;
        break;
      default:
        state = InvoiceState.open;
    }

    var creationDate = DateTime.fromMillisecondsSinceEpoch(0);
    if (json.keys.contains('creation_date') && json['creation_date'] > 0) {
      creationDate = DateTime.fromMillisecondsSinceEpoch(
        json['creation_date'] * 1000,
      );
    }

    var settleDate = DateTime.fromMillisecondsSinceEpoch(0);
    if (json.keys.contains('settle_date') && json['settle_date'] > 0) {
      settleDate = DateTime.fromMillisecondsSinceEpoch(
        json['settle_date'] * 1000,
      );
    }

    return Invoice(
      memo: json['memo'],
      preimage: json['r_preimage'],
      hash: json['r_hash'],
      valuemSat: json['value_msat'],
      creationDate: creationDate,
      settleDate: settleDate,
      paymentRequest: json['payment_request'],
      descriptionHash: json['description_hash'],
      expiry: json['expiry'],
      fallbackAddr: json['fallback_addr'],
      cltvExpiry: json['cltv_expiry'],
      routeHints: _buildRouteHintList(json['route_hints']),
      private: json['private'],
      addIndex: json['add_index'],
      settleIndex: json['settle_index'],
      amtPaidmSat: json['amt_paid_msat'],
      state: state,
      htlcs: _buildHTLCList(json['htlcs']),
      features: _buildFeaturesList(json['features']),
      isKeySend: json['is_keysend'],
    );
  }
}

List<Feature> _buildFeaturesList(List features) {
  final list = <Feature>[];
  for (var f in features) {
    list.add(Feature.fromJson(f));
  }
  return list;
}

List<InvoiceHTLC> _buildHTLCList(List htlcs) {
  final list = <InvoiceHTLC>[];
  for (var h in htlcs) {
    list.add(InvoiceHTLC.fromJson(h));
  }
  return list;
}

List<List<HopHint>> _buildRouteHintList(List hints) {
  final list = <List<HopHint>>[];
  for (var h in hints) {
    list.add(_buildHopHintList(h));
  }
  return list;
}

List<HopHint> _buildHopHintList(Map rh) {
  final list = <HopHint>[];
  rh['hop_hints'].forEach((hh) => list.add(HopHint.fromJson(hh)));
  return list;
}
