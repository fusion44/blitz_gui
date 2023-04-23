// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amp1.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Amp1 extends Amp1 {
  @override
  final String rootShare;
  @override
  final String setId;
  @override
  final int childIndex;
  @override
  final String hash;
  @override
  final String preimage;

  factory _$Amp1([void Function(Amp1Builder)? updates]) =>
      (Amp1Builder()..update(updates))._build();

  _$Amp1._(
      {required this.rootShare,
      required this.setId,
      required this.childIndex,
      required this.hash,
      required this.preimage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(rootShare, r'Amp1', 'rootShare');
    BuiltValueNullFieldError.checkNotNull(setId, r'Amp1', 'setId');
    BuiltValueNullFieldError.checkNotNull(childIndex, r'Amp1', 'childIndex');
    BuiltValueNullFieldError.checkNotNull(hash, r'Amp1', 'hash');
    BuiltValueNullFieldError.checkNotNull(preimage, r'Amp1', 'preimage');
  }

  @override
  Amp1 rebuild(void Function(Amp1Builder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Amp1Builder toBuilder() => Amp1Builder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Amp1 &&
        rootShare == other.rootShare &&
        setId == other.setId &&
        childIndex == other.childIndex &&
        hash == other.hash &&
        preimage == other.preimage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rootShare.hashCode);
    _$hash = $jc(_$hash, setId.hashCode);
    _$hash = $jc(_$hash, childIndex.hashCode);
    _$hash = $jc(_$hash, hash.hashCode);
    _$hash = $jc(_$hash, preimage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Amp1')
          ..add('rootShare', rootShare)
          ..add('setId', setId)
          ..add('childIndex', childIndex)
          ..add('hash', hash)
          ..add('preimage', preimage))
        .toString();
  }
}

class Amp1Builder implements Builder<Amp1, Amp1Builder> {
  _$Amp1? _$v;

  String? _rootShare;
  String? get rootShare => _$this._rootShare;
  set rootShare(String? rootShare) => _$this._rootShare = rootShare;

  String? _setId;
  String? get setId => _$this._setId;
  set setId(String? setId) => _$this._setId = setId;

  int? _childIndex;
  int? get childIndex => _$this._childIndex;
  set childIndex(int? childIndex) => _$this._childIndex = childIndex;

  String? _hash;
  String? get hash => _$this._hash;
  set hash(String? hash) => _$this._hash = hash;

  String? _preimage;
  String? get preimage => _$this._preimage;
  set preimage(String? preimage) => _$this._preimage = preimage;

  Amp1Builder() {
    Amp1._defaults(this);
  }

  Amp1Builder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rootShare = $v.rootShare;
      _setId = $v.setId;
      _childIndex = $v.childIndex;
      _hash = $v.hash;
      _preimage = $v.preimage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Amp1 other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Amp1;
  }

  @override
  void update(void Function(Amp1Builder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Amp1 build() => _build();

  _$Amp1 _build() {
    final _$result = _$v ??
        _$Amp1._(
            rootShare: BuiltValueNullFieldError.checkNotNull(
                rootShare, r'Amp1', 'rootShare'),
            setId:
                BuiltValueNullFieldError.checkNotNull(setId, r'Amp1', 'setId'),
            childIndex: BuiltValueNullFieldError.checkNotNull(
                childIndex, r'Amp1', 'childIndex'),
            hash: BuiltValueNullFieldError.checkNotNull(hash, r'Amp1', 'hash'),
            preimage: BuiltValueNullFieldError.checkNotNull(
                preimage, r'Amp1', 'preimage'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
