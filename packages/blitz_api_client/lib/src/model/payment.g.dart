// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Payment extends Payment {
  @override
  final String paymentHash;
  @override
  final String? paymentPreimage;
  @override
  final int valueMsat;
  @override
  final String? paymentRequest;
  @override
  final PaymentStatus? status;
  @override
  final int feeMsat;
  @override
  final int creationTimeNs;
  @override
  final BuiltList<HTLCAttempt>? htlcs;
  @override
  final int? paymentIndex;
  @override
  final String? label;
  @override
  final PaymentFailureReason? failureReason;

  factory _$Payment([void Function(PaymentBuilder)? updates]) =>
      (PaymentBuilder()..update(updates))._build();

  _$Payment._(
      {required this.paymentHash,
      this.paymentPreimage,
      required this.valueMsat,
      this.paymentRequest,
      this.status,
      required this.feeMsat,
      required this.creationTimeNs,
      this.htlcs,
      this.paymentIndex,
      this.label,
      this.failureReason})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        paymentHash, r'Payment', 'paymentHash');
    BuiltValueNullFieldError.checkNotNull(valueMsat, r'Payment', 'valueMsat');
    BuiltValueNullFieldError.checkNotNull(feeMsat, r'Payment', 'feeMsat');
    BuiltValueNullFieldError.checkNotNull(
        creationTimeNs, r'Payment', 'creationTimeNs');
  }

  @override
  Payment rebuild(void Function(PaymentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentBuilder toBuilder() => PaymentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Payment &&
        paymentHash == other.paymentHash &&
        paymentPreimage == other.paymentPreimage &&
        valueMsat == other.valueMsat &&
        paymentRequest == other.paymentRequest &&
        status == other.status &&
        feeMsat == other.feeMsat &&
        creationTimeNs == other.creationTimeNs &&
        htlcs == other.htlcs &&
        paymentIndex == other.paymentIndex &&
        label == other.label &&
        failureReason == other.failureReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, paymentHash.hashCode);
    _$hash = $jc(_$hash, paymentPreimage.hashCode);
    _$hash = $jc(_$hash, valueMsat.hashCode);
    _$hash = $jc(_$hash, paymentRequest.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, feeMsat.hashCode);
    _$hash = $jc(_$hash, creationTimeNs.hashCode);
    _$hash = $jc(_$hash, htlcs.hashCode);
    _$hash = $jc(_$hash, paymentIndex.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Payment')
          ..add('paymentHash', paymentHash)
          ..add('paymentPreimage', paymentPreimage)
          ..add('valueMsat', valueMsat)
          ..add('paymentRequest', paymentRequest)
          ..add('status', status)
          ..add('feeMsat', feeMsat)
          ..add('creationTimeNs', creationTimeNs)
          ..add('htlcs', htlcs)
          ..add('paymentIndex', paymentIndex)
          ..add('label', label)
          ..add('failureReason', failureReason))
        .toString();
  }
}

class PaymentBuilder implements Builder<Payment, PaymentBuilder> {
  _$Payment? _$v;

  String? _paymentHash;
  String? get paymentHash => _$this._paymentHash;
  set paymentHash(String? paymentHash) => _$this._paymentHash = paymentHash;

  String? _paymentPreimage;
  String? get paymentPreimage => _$this._paymentPreimage;
  set paymentPreimage(String? paymentPreimage) =>
      _$this._paymentPreimage = paymentPreimage;

  int? _valueMsat;
  int? get valueMsat => _$this._valueMsat;
  set valueMsat(int? valueMsat) => _$this._valueMsat = valueMsat;

  String? _paymentRequest;
  String? get paymentRequest => _$this._paymentRequest;
  set paymentRequest(String? paymentRequest) =>
      _$this._paymentRequest = paymentRequest;

  PaymentStatus? _status;
  PaymentStatus? get status => _$this._status;
  set status(PaymentStatus? status) => _$this._status = status;

  int? _feeMsat;
  int? get feeMsat => _$this._feeMsat;
  set feeMsat(int? feeMsat) => _$this._feeMsat = feeMsat;

  int? _creationTimeNs;
  int? get creationTimeNs => _$this._creationTimeNs;
  set creationTimeNs(int? creationTimeNs) =>
      _$this._creationTimeNs = creationTimeNs;

  ListBuilder<HTLCAttempt>? _htlcs;
  ListBuilder<HTLCAttempt> get htlcs =>
      _$this._htlcs ??= ListBuilder<HTLCAttempt>();
  set htlcs(ListBuilder<HTLCAttempt>? htlcs) => _$this._htlcs = htlcs;

  int? _paymentIndex;
  int? get paymentIndex => _$this._paymentIndex;
  set paymentIndex(int? paymentIndex) => _$this._paymentIndex = paymentIndex;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  PaymentFailureReason? _failureReason;
  PaymentFailureReason? get failureReason => _$this._failureReason;
  set failureReason(PaymentFailureReason? failureReason) =>
      _$this._failureReason = failureReason;

  PaymentBuilder() {
    Payment._defaults(this);
  }

  PaymentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _paymentHash = $v.paymentHash;
      _paymentPreimage = $v.paymentPreimage;
      _valueMsat = $v.valueMsat;
      _paymentRequest = $v.paymentRequest;
      _status = $v.status;
      _feeMsat = $v.feeMsat;
      _creationTimeNs = $v.creationTimeNs;
      _htlcs = $v.htlcs?.toBuilder();
      _paymentIndex = $v.paymentIndex;
      _label = $v.label;
      _failureReason = $v.failureReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Payment other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Payment;
  }

  @override
  void update(void Function(PaymentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Payment build() => _build();

  _$Payment _build() {
    _$Payment _$result;
    try {
      _$result = _$v ??
          _$Payment._(
              paymentHash: BuiltValueNullFieldError.checkNotNull(
                  paymentHash, r'Payment', 'paymentHash'),
              paymentPreimage: paymentPreimage,
              valueMsat: BuiltValueNullFieldError.checkNotNull(
                  valueMsat, r'Payment', 'valueMsat'),
              paymentRequest: paymentRequest,
              status: status,
              feeMsat: BuiltValueNullFieldError.checkNotNull(
                  feeMsat, r'Payment', 'feeMsat'),
              creationTimeNs: BuiltValueNullFieldError.checkNotNull(
                  creationTimeNs, r'Payment', 'creationTimeNs'),
              htlcs: _htlcs?.build(),
              paymentIndex: paymentIndex,
              label: label,
              failureReason: failureReason);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'htlcs';
        _htlcs?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Payment', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
