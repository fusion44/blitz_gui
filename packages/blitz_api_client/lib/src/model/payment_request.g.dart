// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaymentRequest extends PaymentRequest {
  @override
  final String destination;
  @override
  final String paymentHash;
  @override
  final int? numSatoshis;
  @override
  final int timestamp;
  @override
  final int expiry;
  @override
  final String description;
  @override
  final String? descriptionHash;
  @override
  final String? fallbackAddr;
  @override
  final int cltvExpiry;
  @override
  final BuiltList<RouteHint>? routeHints;
  @override
  final String? paymentAddr;
  @override
  final int? numMsat;
  @override
  final BuiltList<FeaturesEntry>? features;
  @override
  final String? currency;

  factory _$PaymentRequest([void Function(PaymentRequestBuilder)? updates]) =>
      (PaymentRequestBuilder()..update(updates))._build();

  _$PaymentRequest._(
      {required this.destination,
      required this.paymentHash,
      this.numSatoshis,
      required this.timestamp,
      required this.expiry,
      required this.description,
      this.descriptionHash,
      this.fallbackAddr,
      required this.cltvExpiry,
      this.routeHints,
      this.paymentAddr,
      this.numMsat,
      this.features,
      this.currency})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        destination, r'PaymentRequest', 'destination');
    BuiltValueNullFieldError.checkNotNull(
        paymentHash, r'PaymentRequest', 'paymentHash');
    BuiltValueNullFieldError.checkNotNull(
        timestamp, r'PaymentRequest', 'timestamp');
    BuiltValueNullFieldError.checkNotNull(expiry, r'PaymentRequest', 'expiry');
    BuiltValueNullFieldError.checkNotNull(
        description, r'PaymentRequest', 'description');
    BuiltValueNullFieldError.checkNotNull(
        cltvExpiry, r'PaymentRequest', 'cltvExpiry');
  }

  @override
  PaymentRequest rebuild(void Function(PaymentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentRequestBuilder toBuilder() => PaymentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentRequest &&
        destination == other.destination &&
        paymentHash == other.paymentHash &&
        numSatoshis == other.numSatoshis &&
        timestamp == other.timestamp &&
        expiry == other.expiry &&
        description == other.description &&
        descriptionHash == other.descriptionHash &&
        fallbackAddr == other.fallbackAddr &&
        cltvExpiry == other.cltvExpiry &&
        routeHints == other.routeHints &&
        paymentAddr == other.paymentAddr &&
        numMsat == other.numMsat &&
        features == other.features &&
        currency == other.currency;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, destination.hashCode);
    _$hash = $jc(_$hash, paymentHash.hashCode);
    _$hash = $jc(_$hash, numSatoshis.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, expiry.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, descriptionHash.hashCode);
    _$hash = $jc(_$hash, fallbackAddr.hashCode);
    _$hash = $jc(_$hash, cltvExpiry.hashCode);
    _$hash = $jc(_$hash, routeHints.hashCode);
    _$hash = $jc(_$hash, paymentAddr.hashCode);
    _$hash = $jc(_$hash, numMsat.hashCode);
    _$hash = $jc(_$hash, features.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaymentRequest')
          ..add('destination', destination)
          ..add('paymentHash', paymentHash)
          ..add('numSatoshis', numSatoshis)
          ..add('timestamp', timestamp)
          ..add('expiry', expiry)
          ..add('description', description)
          ..add('descriptionHash', descriptionHash)
          ..add('fallbackAddr', fallbackAddr)
          ..add('cltvExpiry', cltvExpiry)
          ..add('routeHints', routeHints)
          ..add('paymentAddr', paymentAddr)
          ..add('numMsat', numMsat)
          ..add('features', features)
          ..add('currency', currency))
        .toString();
  }
}

class PaymentRequestBuilder
    implements Builder<PaymentRequest, PaymentRequestBuilder> {
  _$PaymentRequest? _$v;

  String? _destination;
  String? get destination => _$this._destination;
  set destination(String? destination) => _$this._destination = destination;

  String? _paymentHash;
  String? get paymentHash => _$this._paymentHash;
  set paymentHash(String? paymentHash) => _$this._paymentHash = paymentHash;

  int? _numSatoshis;
  int? get numSatoshis => _$this._numSatoshis;
  set numSatoshis(int? numSatoshis) => _$this._numSatoshis = numSatoshis;

  int? _timestamp;
  int? get timestamp => _$this._timestamp;
  set timestamp(int? timestamp) => _$this._timestamp = timestamp;

  int? _expiry;
  int? get expiry => _$this._expiry;
  set expiry(int? expiry) => _$this._expiry = expiry;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _descriptionHash;
  String? get descriptionHash => _$this._descriptionHash;
  set descriptionHash(String? descriptionHash) =>
      _$this._descriptionHash = descriptionHash;

  String? _fallbackAddr;
  String? get fallbackAddr => _$this._fallbackAddr;
  set fallbackAddr(String? fallbackAddr) => _$this._fallbackAddr = fallbackAddr;

  int? _cltvExpiry;
  int? get cltvExpiry => _$this._cltvExpiry;
  set cltvExpiry(int? cltvExpiry) => _$this._cltvExpiry = cltvExpiry;

  ListBuilder<RouteHint>? _routeHints;
  ListBuilder<RouteHint> get routeHints =>
      _$this._routeHints ??= ListBuilder<RouteHint>();
  set routeHints(ListBuilder<RouteHint>? routeHints) =>
      _$this._routeHints = routeHints;

  String? _paymentAddr;
  String? get paymentAddr => _$this._paymentAddr;
  set paymentAddr(String? paymentAddr) => _$this._paymentAddr = paymentAddr;

  int? _numMsat;
  int? get numMsat => _$this._numMsat;
  set numMsat(int? numMsat) => _$this._numMsat = numMsat;

  ListBuilder<FeaturesEntry>? _features;
  ListBuilder<FeaturesEntry> get features =>
      _$this._features ??= ListBuilder<FeaturesEntry>();
  set features(ListBuilder<FeaturesEntry>? features) =>
      _$this._features = features;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  PaymentRequestBuilder() {
    PaymentRequest._defaults(this);
  }

  PaymentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _destination = $v.destination;
      _paymentHash = $v.paymentHash;
      _numSatoshis = $v.numSatoshis;
      _timestamp = $v.timestamp;
      _expiry = $v.expiry;
      _description = $v.description;
      _descriptionHash = $v.descriptionHash;
      _fallbackAddr = $v.fallbackAddr;
      _cltvExpiry = $v.cltvExpiry;
      _routeHints = $v.routeHints?.toBuilder();
      _paymentAddr = $v.paymentAddr;
      _numMsat = $v.numMsat;
      _features = $v.features?.toBuilder();
      _currency = $v.currency;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PaymentRequest;
  }

  @override
  void update(void Function(PaymentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentRequest build() => _build();

  _$PaymentRequest _build() {
    _$PaymentRequest _$result;
    try {
      _$result = _$v ??
          _$PaymentRequest._(
              destination: BuiltValueNullFieldError.checkNotNull(
                  destination, r'PaymentRequest', 'destination'),
              paymentHash: BuiltValueNullFieldError.checkNotNull(
                  paymentHash, r'PaymentRequest', 'paymentHash'),
              numSatoshis: numSatoshis,
              timestamp: BuiltValueNullFieldError.checkNotNull(
                  timestamp, r'PaymentRequest', 'timestamp'),
              expiry: BuiltValueNullFieldError.checkNotNull(
                  expiry, r'PaymentRequest', 'expiry'),
              description: BuiltValueNullFieldError.checkNotNull(
                  description, r'PaymentRequest', 'description'),
              descriptionHash: descriptionHash,
              fallbackAddr: fallbackAddr,
              cltvExpiry: BuiltValueNullFieldError.checkNotNull(
                  cltvExpiry, r'PaymentRequest', 'cltvExpiry'),
              routeHints: _routeHints?.build(),
              paymentAddr: paymentAddr,
              numMsat: numMsat,
              features: _features?.build(),
              currency: currency);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'routeHints';
        _routeHints?.build();

        _$failedField = 'features';
        _features?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PaymentRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
