// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_htlc.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InvoiceHTLC extends InvoiceHTLC {
  @override
  final int chanId;
  @override
  final int htlcIndex;
  @override
  final int amtMsat;
  @override
  final int acceptHeight;
  @override
  final int acceptTime;
  @override
  final int resolveTime;
  @override
  final int expiryHeight;
  @override
  final InvoiceHTLCState? state;
  @override
  final BuiltList<CustomRecordsEntry>? customRecords;
  @override
  final int mppTotalAmtMsat;
  @override
  final Amp1? amp;

  factory _$InvoiceHTLC([void Function(InvoiceHTLCBuilder)? updates]) =>
      (InvoiceHTLCBuilder()..update(updates))._build();

  _$InvoiceHTLC._(
      {required this.chanId,
      required this.htlcIndex,
      required this.amtMsat,
      required this.acceptHeight,
      required this.acceptTime,
      required this.resolveTime,
      required this.expiryHeight,
      this.state,
      this.customRecords,
      required this.mppTotalAmtMsat,
      this.amp})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(chanId, r'InvoiceHTLC', 'chanId');
    BuiltValueNullFieldError.checkNotNull(
        htlcIndex, r'InvoiceHTLC', 'htlcIndex');
    BuiltValueNullFieldError.checkNotNull(amtMsat, r'InvoiceHTLC', 'amtMsat');
    BuiltValueNullFieldError.checkNotNull(
        acceptHeight, r'InvoiceHTLC', 'acceptHeight');
    BuiltValueNullFieldError.checkNotNull(
        acceptTime, r'InvoiceHTLC', 'acceptTime');
    BuiltValueNullFieldError.checkNotNull(
        resolveTime, r'InvoiceHTLC', 'resolveTime');
    BuiltValueNullFieldError.checkNotNull(
        expiryHeight, r'InvoiceHTLC', 'expiryHeight');
    BuiltValueNullFieldError.checkNotNull(
        mppTotalAmtMsat, r'InvoiceHTLC', 'mppTotalAmtMsat');
  }

  @override
  InvoiceHTLC rebuild(void Function(InvoiceHTLCBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceHTLCBuilder toBuilder() => InvoiceHTLCBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvoiceHTLC &&
        chanId == other.chanId &&
        htlcIndex == other.htlcIndex &&
        amtMsat == other.amtMsat &&
        acceptHeight == other.acceptHeight &&
        acceptTime == other.acceptTime &&
        resolveTime == other.resolveTime &&
        expiryHeight == other.expiryHeight &&
        state == other.state &&
        customRecords == other.customRecords &&
        mppTotalAmtMsat == other.mppTotalAmtMsat &&
        amp == other.amp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chanId.hashCode);
    _$hash = $jc(_$hash, htlcIndex.hashCode);
    _$hash = $jc(_$hash, amtMsat.hashCode);
    _$hash = $jc(_$hash, acceptHeight.hashCode);
    _$hash = $jc(_$hash, acceptTime.hashCode);
    _$hash = $jc(_$hash, resolveTime.hashCode);
    _$hash = $jc(_$hash, expiryHeight.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, customRecords.hashCode);
    _$hash = $jc(_$hash, mppTotalAmtMsat.hashCode);
    _$hash = $jc(_$hash, amp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InvoiceHTLC')
          ..add('chanId', chanId)
          ..add('htlcIndex', htlcIndex)
          ..add('amtMsat', amtMsat)
          ..add('acceptHeight', acceptHeight)
          ..add('acceptTime', acceptTime)
          ..add('resolveTime', resolveTime)
          ..add('expiryHeight', expiryHeight)
          ..add('state', state)
          ..add('customRecords', customRecords)
          ..add('mppTotalAmtMsat', mppTotalAmtMsat)
          ..add('amp', amp))
        .toString();
  }
}

class InvoiceHTLCBuilder implements Builder<InvoiceHTLC, InvoiceHTLCBuilder> {
  _$InvoiceHTLC? _$v;

  int? _chanId;
  int? get chanId => _$this._chanId;
  set chanId(int? chanId) => _$this._chanId = chanId;

  int? _htlcIndex;
  int? get htlcIndex => _$this._htlcIndex;
  set htlcIndex(int? htlcIndex) => _$this._htlcIndex = htlcIndex;

  int? _amtMsat;
  int? get amtMsat => _$this._amtMsat;
  set amtMsat(int? amtMsat) => _$this._amtMsat = amtMsat;

  int? _acceptHeight;
  int? get acceptHeight => _$this._acceptHeight;
  set acceptHeight(int? acceptHeight) => _$this._acceptHeight = acceptHeight;

  int? _acceptTime;
  int? get acceptTime => _$this._acceptTime;
  set acceptTime(int? acceptTime) => _$this._acceptTime = acceptTime;

  int? _resolveTime;
  int? get resolveTime => _$this._resolveTime;
  set resolveTime(int? resolveTime) => _$this._resolveTime = resolveTime;

  int? _expiryHeight;
  int? get expiryHeight => _$this._expiryHeight;
  set expiryHeight(int? expiryHeight) => _$this._expiryHeight = expiryHeight;

  InvoiceHTLCState? _state;
  InvoiceHTLCState? get state => _$this._state;
  set state(InvoiceHTLCState? state) => _$this._state = state;

  ListBuilder<CustomRecordsEntry>? _customRecords;
  ListBuilder<CustomRecordsEntry> get customRecords =>
      _$this._customRecords ??= ListBuilder<CustomRecordsEntry>();
  set customRecords(ListBuilder<CustomRecordsEntry>? customRecords) =>
      _$this._customRecords = customRecords;

  int? _mppTotalAmtMsat;
  int? get mppTotalAmtMsat => _$this._mppTotalAmtMsat;
  set mppTotalAmtMsat(int? mppTotalAmtMsat) =>
      _$this._mppTotalAmtMsat = mppTotalAmtMsat;

  Amp1Builder? _amp;
  Amp1Builder get amp => _$this._amp ??= Amp1Builder();
  set amp(Amp1Builder? amp) => _$this._amp = amp;

  InvoiceHTLCBuilder() {
    InvoiceHTLC._defaults(this);
  }

  InvoiceHTLCBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chanId = $v.chanId;
      _htlcIndex = $v.htlcIndex;
      _amtMsat = $v.amtMsat;
      _acceptHeight = $v.acceptHeight;
      _acceptTime = $v.acceptTime;
      _resolveTime = $v.resolveTime;
      _expiryHeight = $v.expiryHeight;
      _state = $v.state;
      _customRecords = $v.customRecords?.toBuilder();
      _mppTotalAmtMsat = $v.mppTotalAmtMsat;
      _amp = $v.amp?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvoiceHTLC other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$InvoiceHTLC;
  }

  @override
  void update(void Function(InvoiceHTLCBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvoiceHTLC build() => _build();

  _$InvoiceHTLC _build() {
    _$InvoiceHTLC _$result;
    try {
      _$result = _$v ??
          _$InvoiceHTLC._(
              chanId: BuiltValueNullFieldError.checkNotNull(
                  chanId, r'InvoiceHTLC', 'chanId'),
              htlcIndex: BuiltValueNullFieldError.checkNotNull(
                  htlcIndex, r'InvoiceHTLC', 'htlcIndex'),
              amtMsat: BuiltValueNullFieldError.checkNotNull(
                  amtMsat, r'InvoiceHTLC', 'amtMsat'),
              acceptHeight: BuiltValueNullFieldError.checkNotNull(
                  acceptHeight, r'InvoiceHTLC', 'acceptHeight'),
              acceptTime: BuiltValueNullFieldError.checkNotNull(
                  acceptTime, r'InvoiceHTLC', 'acceptTime'),
              resolveTime: BuiltValueNullFieldError.checkNotNull(
                  resolveTime, r'InvoiceHTLC', 'resolveTime'),
              expiryHeight: BuiltValueNullFieldError.checkNotNull(
                  expiryHeight, r'InvoiceHTLC', 'expiryHeight'),
              state: state,
              customRecords: _customRecords?.build(),
              mppTotalAmtMsat: BuiltValueNullFieldError.checkNotNull(
                  mppTotalAmtMsat, r'InvoiceHTLC', 'mppTotalAmtMsat'),
              amp: _amp?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'customRecords';
        _customRecords?.build();

        _$failedField = 'amp';
        _amp?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'InvoiceHTLC', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
