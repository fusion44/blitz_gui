// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amp.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Amp extends Amp {
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

  factory _$Amp([void Function(AmpBuilder)? updates]) =>
      (AmpBuilder()..update(updates))._build();

  _$Amp._(
      {required this.rootShare,
      required this.setId,
      required this.childIndex,
      required this.hash,
      required this.preimage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(rootShare, r'Amp', 'rootShare');
    BuiltValueNullFieldError.checkNotNull(setId, r'Amp', 'setId');
    BuiltValueNullFieldError.checkNotNull(childIndex, r'Amp', 'childIndex');
    BuiltValueNullFieldError.checkNotNull(hash, r'Amp', 'hash');
    BuiltValueNullFieldError.checkNotNull(preimage, r'Amp', 'preimage');
  }

  @override
  Amp rebuild(void Function(AmpBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AmpBuilder toBuilder() => AmpBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Amp &&
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
    return (newBuiltValueToStringHelper(r'Amp')
          ..add('rootShare', rootShare)
          ..add('setId', setId)
          ..add('childIndex', childIndex)
          ..add('hash', hash)
          ..add('preimage', preimage))
        .toString();
  }
}

class AmpBuilder implements Builder<Amp, AmpBuilder> {
  _$Amp? _$v;

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

  AmpBuilder() {
    Amp._defaults(this);
  }

  AmpBuilder get _$this {
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
  void replace(Amp other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Amp;
  }

  @override
  void update(void Function(AmpBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Amp build() => _build();

  _$Amp _build() {
    final _$result = _$v ??
        _$Amp._(
            rootShare: BuiltValueNullFieldError.checkNotNull(
                rootShare, r'Amp', 'rootShare'),
            setId:
                BuiltValueNullFieldError.checkNotNull(setId, r'Amp', 'setId'),
            childIndex: BuiltValueNullFieldError.checkNotNull(
                childIndex, r'Amp', 'childIndex'),
            hash: BuiltValueNullFieldError.checkNotNull(hash, r'Amp', 'hash'),
            preimage: BuiltValueNullFieldError.checkNotNull(
                preimage, r'Amp', 'preimage'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
