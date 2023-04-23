// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Invoice extends Invoice {
  @override
  final String? memo;
  @override
  final String? rPreimage;
  @override
  final String? rHash;
  @override
  final int valueMsat;
  @override
  final bool? settled;
  @override
  final int? creationDate;
  @override
  final int? settleDate;
  @override
  final int? expiryDate;
  @override
  final String? paymentRequest;
  @override
  final String? descriptionHash;
  @override
  final int? expiry;
  @override
  final String? fallbackAddr;
  @override
  final int? cltvExpiry;
  @override
  final BuiltList<RouteHint>? routeHints;
  @override
  final bool? private;
  @override
  final String addIndex;
  @override
  final int? settleIndex;
  @override
  final int? amtPaidSat;
  @override
  final int? amtPaidMsat;
  @override
  final InvoiceState? state;
  @override
  final BuiltList<InvoiceHTLC>? htlcs;
  @override
  final BuiltList<FeaturesEntry>? features;
  @override
  final bool? isKeysend;
  @override
  final String? paymentAddr;
  @override
  final bool? isAmp;

  factory _$Invoice([void Function(InvoiceBuilder)? updates]) =>
      (InvoiceBuilder()..update(updates))._build();

  _$Invoice._(
      {this.memo,
      this.rPreimage,
      this.rHash,
      required this.valueMsat,
      this.settled,
      this.creationDate,
      this.settleDate,
      this.expiryDate,
      this.paymentRequest,
      this.descriptionHash,
      this.expiry,
      this.fallbackAddr,
      this.cltvExpiry,
      this.routeHints,
      this.private,
      required this.addIndex,
      this.settleIndex,
      this.amtPaidSat,
      this.amtPaidMsat,
      this.state,
      this.htlcs,
      this.features,
      this.isKeysend,
      this.paymentAddr,
      this.isAmp})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(valueMsat, r'Invoice', 'valueMsat');
    BuiltValueNullFieldError.checkNotNull(addIndex, r'Invoice', 'addIndex');
  }

  @override
  Invoice rebuild(void Function(InvoiceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceBuilder toBuilder() => InvoiceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Invoice &&
        memo == other.memo &&
        rPreimage == other.rPreimage &&
        rHash == other.rHash &&
        valueMsat == other.valueMsat &&
        settled == other.settled &&
        creationDate == other.creationDate &&
        settleDate == other.settleDate &&
        expiryDate == other.expiryDate &&
        paymentRequest == other.paymentRequest &&
        descriptionHash == other.descriptionHash &&
        expiry == other.expiry &&
        fallbackAddr == other.fallbackAddr &&
        cltvExpiry == other.cltvExpiry &&
        routeHints == other.routeHints &&
        private == other.private &&
        addIndex == other.addIndex &&
        settleIndex == other.settleIndex &&
        amtPaidSat == other.amtPaidSat &&
        amtPaidMsat == other.amtPaidMsat &&
        state == other.state &&
        htlcs == other.htlcs &&
        features == other.features &&
        isKeysend == other.isKeysend &&
        paymentAddr == other.paymentAddr &&
        isAmp == other.isAmp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, memo.hashCode);
    _$hash = $jc(_$hash, rPreimage.hashCode);
    _$hash = $jc(_$hash, rHash.hashCode);
    _$hash = $jc(_$hash, valueMsat.hashCode);
    _$hash = $jc(_$hash, settled.hashCode);
    _$hash = $jc(_$hash, creationDate.hashCode);
    _$hash = $jc(_$hash, settleDate.hashCode);
    _$hash = $jc(_$hash, expiryDate.hashCode);
    _$hash = $jc(_$hash, paymentRequest.hashCode);
    _$hash = $jc(_$hash, descriptionHash.hashCode);
    _$hash = $jc(_$hash, expiry.hashCode);
    _$hash = $jc(_$hash, fallbackAddr.hashCode);
    _$hash = $jc(_$hash, cltvExpiry.hashCode);
    _$hash = $jc(_$hash, routeHints.hashCode);
    _$hash = $jc(_$hash, private.hashCode);
    _$hash = $jc(_$hash, addIndex.hashCode);
    _$hash = $jc(_$hash, settleIndex.hashCode);
    _$hash = $jc(_$hash, amtPaidSat.hashCode);
    _$hash = $jc(_$hash, amtPaidMsat.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, htlcs.hashCode);
    _$hash = $jc(_$hash, features.hashCode);
    _$hash = $jc(_$hash, isKeysend.hashCode);
    _$hash = $jc(_$hash, paymentAddr.hashCode);
    _$hash = $jc(_$hash, isAmp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Invoice')
          ..add('memo', memo)
          ..add('rPreimage', rPreimage)
          ..add('rHash', rHash)
          ..add('valueMsat', valueMsat)
          ..add('settled', settled)
          ..add('creationDate', creationDate)
          ..add('settleDate', settleDate)
          ..add('expiryDate', expiryDate)
          ..add('paymentRequest', paymentRequest)
          ..add('descriptionHash', descriptionHash)
          ..add('expiry', expiry)
          ..add('fallbackAddr', fallbackAddr)
          ..add('cltvExpiry', cltvExpiry)
          ..add('routeHints', routeHints)
          ..add('private', private)
          ..add('addIndex', addIndex)
          ..add('settleIndex', settleIndex)
          ..add('amtPaidSat', amtPaidSat)
          ..add('amtPaidMsat', amtPaidMsat)
          ..add('state', state)
          ..add('htlcs', htlcs)
          ..add('features', features)
          ..add('isKeysend', isKeysend)
          ..add('paymentAddr', paymentAddr)
          ..add('isAmp', isAmp))
        .toString();
  }
}

class InvoiceBuilder implements Builder<Invoice, InvoiceBuilder> {
  _$Invoice? _$v;

  String? _memo;
  String? get memo => _$this._memo;
  set memo(String? memo) => _$this._memo = memo;

  String? _rPreimage;
  String? get rPreimage => _$this._rPreimage;
  set rPreimage(String? rPreimage) => _$this._rPreimage = rPreimage;

  String? _rHash;
  String? get rHash => _$this._rHash;
  set rHash(String? rHash) => _$this._rHash = rHash;

  int? _valueMsat;
  int? get valueMsat => _$this._valueMsat;
  set valueMsat(int? valueMsat) => _$this._valueMsat = valueMsat;

  bool? _settled;
  bool? get settled => _$this._settled;
  set settled(bool? settled) => _$this._settled = settled;

  int? _creationDate;
  int? get creationDate => _$this._creationDate;
  set creationDate(int? creationDate) => _$this._creationDate = creationDate;

  int? _settleDate;
  int? get settleDate => _$this._settleDate;
  set settleDate(int? settleDate) => _$this._settleDate = settleDate;

  int? _expiryDate;
  int? get expiryDate => _$this._expiryDate;
  set expiryDate(int? expiryDate) => _$this._expiryDate = expiryDate;

  String? _paymentRequest;
  String? get paymentRequest => _$this._paymentRequest;
  set paymentRequest(String? paymentRequest) =>
      _$this._paymentRequest = paymentRequest;

  String? _descriptionHash;
  String? get descriptionHash => _$this._descriptionHash;
  set descriptionHash(String? descriptionHash) =>
      _$this._descriptionHash = descriptionHash;

  int? _expiry;
  int? get expiry => _$this._expiry;
  set expiry(int? expiry) => _$this._expiry = expiry;

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

  bool? _private;
  bool? get private => _$this._private;
  set private(bool? private) => _$this._private = private;

  String? _addIndex;
  String? get addIndex => _$this._addIndex;
  set addIndex(String? addIndex) => _$this._addIndex = addIndex;

  int? _settleIndex;
  int? get settleIndex => _$this._settleIndex;
  set settleIndex(int? settleIndex) => _$this._settleIndex = settleIndex;

  int? _amtPaidSat;
  int? get amtPaidSat => _$this._amtPaidSat;
  set amtPaidSat(int? amtPaidSat) => _$this._amtPaidSat = amtPaidSat;

  int? _amtPaidMsat;
  int? get amtPaidMsat => _$this._amtPaidMsat;
  set amtPaidMsat(int? amtPaidMsat) => _$this._amtPaidMsat = amtPaidMsat;

  InvoiceState? _state;
  InvoiceState? get state => _$this._state;
  set state(InvoiceState? state) => _$this._state = state;

  ListBuilder<InvoiceHTLC>? _htlcs;
  ListBuilder<InvoiceHTLC> get htlcs =>
      _$this._htlcs ??= ListBuilder<InvoiceHTLC>();
  set htlcs(ListBuilder<InvoiceHTLC>? htlcs) => _$this._htlcs = htlcs;

  ListBuilder<FeaturesEntry>? _features;
  ListBuilder<FeaturesEntry> get features =>
      _$this._features ??= ListBuilder<FeaturesEntry>();
  set features(ListBuilder<FeaturesEntry>? features) =>
      _$this._features = features;

  bool? _isKeysend;
  bool? get isKeysend => _$this._isKeysend;
  set isKeysend(bool? isKeysend) => _$this._isKeysend = isKeysend;

  String? _paymentAddr;
  String? get paymentAddr => _$this._paymentAddr;
  set paymentAddr(String? paymentAddr) => _$this._paymentAddr = paymentAddr;

  bool? _isAmp;
  bool? get isAmp => _$this._isAmp;
  set isAmp(bool? isAmp) => _$this._isAmp = isAmp;

  InvoiceBuilder() {
    Invoice._defaults(this);
  }

  InvoiceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _memo = $v.memo;
      _rPreimage = $v.rPreimage;
      _rHash = $v.rHash;
      _valueMsat = $v.valueMsat;
      _settled = $v.settled;
      _creationDate = $v.creationDate;
      _settleDate = $v.settleDate;
      _expiryDate = $v.expiryDate;
      _paymentRequest = $v.paymentRequest;
      _descriptionHash = $v.descriptionHash;
      _expiry = $v.expiry;
      _fallbackAddr = $v.fallbackAddr;
      _cltvExpiry = $v.cltvExpiry;
      _routeHints = $v.routeHints?.toBuilder();
      _private = $v.private;
      _addIndex = $v.addIndex;
      _settleIndex = $v.settleIndex;
      _amtPaidSat = $v.amtPaidSat;
      _amtPaidMsat = $v.amtPaidMsat;
      _state = $v.state;
      _htlcs = $v.htlcs?.toBuilder();
      _features = $v.features?.toBuilder();
      _isKeysend = $v.isKeysend;
      _paymentAddr = $v.paymentAddr;
      _isAmp = $v.isAmp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Invoice other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Invoice;
  }

  @override
  void update(void Function(InvoiceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Invoice build() => _build();

  _$Invoice _build() {
    _$Invoice _$result;
    try {
      _$result = _$v ??
          _$Invoice._(
              memo: memo,
              rPreimage: rPreimage,
              rHash: rHash,
              valueMsat: BuiltValueNullFieldError.checkNotNull(
                  valueMsat, r'Invoice', 'valueMsat'),
              settled: settled,
              creationDate: creationDate,
              settleDate: settleDate,
              expiryDate: expiryDate,
              paymentRequest: paymentRequest,
              descriptionHash: descriptionHash,
              expiry: expiry,
              fallbackAddr: fallbackAddr,
              cltvExpiry: cltvExpiry,
              routeHints: _routeHints?.build(),
              private: private,
              addIndex: BuiltValueNullFieldError.checkNotNull(
                  addIndex, r'Invoice', 'addIndex'),
              settleIndex: settleIndex,
              amtPaidSat: amtPaidSat,
              amtPaidMsat: amtPaidMsat,
              state: state,
              htlcs: _htlcs?.build(),
              features: _features?.build(),
              isKeysend: isKeysend,
              paymentAddr: paymentAddr,
              isAmp: isAmp);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'routeHints';
        _routeHints?.build();

        _$failedField = 'htlcs';
        _htlcs?.build();
        _$failedField = 'features';
        _features?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Invoice', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
