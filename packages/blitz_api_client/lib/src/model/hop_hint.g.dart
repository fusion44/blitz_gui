// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hop_hint.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HopHint extends HopHint {
  @override
  final String nodeId;
  @override
  final String chanId;
  @override
  final int feeBaseMsat;
  @override
  final int feeProportionalMillionths;
  @override
  final int cltvExpiryDelta;

  factory _$HopHint([void Function(HopHintBuilder)? updates]) =>
      (HopHintBuilder()..update(updates))._build();

  _$HopHint._(
      {required this.nodeId,
      required this.chanId,
      required this.feeBaseMsat,
      required this.feeProportionalMillionths,
      required this.cltvExpiryDelta})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(nodeId, r'HopHint', 'nodeId');
    BuiltValueNullFieldError.checkNotNull(chanId, r'HopHint', 'chanId');
    BuiltValueNullFieldError.checkNotNull(
        feeBaseMsat, r'HopHint', 'feeBaseMsat');
    BuiltValueNullFieldError.checkNotNull(
        feeProportionalMillionths, r'HopHint', 'feeProportionalMillionths');
    BuiltValueNullFieldError.checkNotNull(
        cltvExpiryDelta, r'HopHint', 'cltvExpiryDelta');
  }

  @override
  HopHint rebuild(void Function(HopHintBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HopHintBuilder toBuilder() => HopHintBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HopHint &&
        nodeId == other.nodeId &&
        chanId == other.chanId &&
        feeBaseMsat == other.feeBaseMsat &&
        feeProportionalMillionths == other.feeProportionalMillionths &&
        cltvExpiryDelta == other.cltvExpiryDelta;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, nodeId.hashCode);
    _$hash = $jc(_$hash, chanId.hashCode);
    _$hash = $jc(_$hash, feeBaseMsat.hashCode);
    _$hash = $jc(_$hash, feeProportionalMillionths.hashCode);
    _$hash = $jc(_$hash, cltvExpiryDelta.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HopHint')
          ..add('nodeId', nodeId)
          ..add('chanId', chanId)
          ..add('feeBaseMsat', feeBaseMsat)
          ..add('feeProportionalMillionths', feeProportionalMillionths)
          ..add('cltvExpiryDelta', cltvExpiryDelta))
        .toString();
  }
}

class HopHintBuilder implements Builder<HopHint, HopHintBuilder> {
  _$HopHint? _$v;

  String? _nodeId;
  String? get nodeId => _$this._nodeId;
  set nodeId(String? nodeId) => _$this._nodeId = nodeId;

  String? _chanId;
  String? get chanId => _$this._chanId;
  set chanId(String? chanId) => _$this._chanId = chanId;

  int? _feeBaseMsat;
  int? get feeBaseMsat => _$this._feeBaseMsat;
  set feeBaseMsat(int? feeBaseMsat) => _$this._feeBaseMsat = feeBaseMsat;

  int? _feeProportionalMillionths;
  int? get feeProportionalMillionths => _$this._feeProportionalMillionths;
  set feeProportionalMillionths(int? feeProportionalMillionths) =>
      _$this._feeProportionalMillionths = feeProportionalMillionths;

  int? _cltvExpiryDelta;
  int? get cltvExpiryDelta => _$this._cltvExpiryDelta;
  set cltvExpiryDelta(int? cltvExpiryDelta) =>
      _$this._cltvExpiryDelta = cltvExpiryDelta;

  HopHintBuilder() {
    HopHint._defaults(this);
  }

  HopHintBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nodeId = $v.nodeId;
      _chanId = $v.chanId;
      _feeBaseMsat = $v.feeBaseMsat;
      _feeProportionalMillionths = $v.feeProportionalMillionths;
      _cltvExpiryDelta = $v.cltvExpiryDelta;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HopHint other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HopHint;
  }

  @override
  void update(void Function(HopHintBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HopHint build() => _build();

  _$HopHint _build() {
    final _$result = _$v ??
        _$HopHint._(
            nodeId: BuiltValueNullFieldError.checkNotNull(
                nodeId, r'HopHint', 'nodeId'),
            chanId: BuiltValueNullFieldError.checkNotNull(
                chanId, r'HopHint', 'chanId'),
            feeBaseMsat: BuiltValueNullFieldError.checkNotNull(
                feeBaseMsat, r'HopHint', 'feeBaseMsat'),
            feeProportionalMillionths: BuiltValueNullFieldError.checkNotNull(
                feeProportionalMillionths,
                r'HopHint',
                'feeProportionalMillionths'),
            cltvExpiryDelta: BuiltValueNullFieldError.checkNotNull(
                cltvExpiryDelta, r'HopHint', 'cltvExpiryDelta'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
