// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amp_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AMPRecord extends AMPRecord {
  @override
  final String rootShare;
  @override
  final String setId;
  @override
  final int childIndex;

  factory _$AMPRecord([void Function(AMPRecordBuilder)? updates]) =>
      (AMPRecordBuilder()..update(updates))._build();

  _$AMPRecord._(
      {required this.rootShare, required this.setId, required this.childIndex})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(rootShare, r'AMPRecord', 'rootShare');
    BuiltValueNullFieldError.checkNotNull(setId, r'AMPRecord', 'setId');
    BuiltValueNullFieldError.checkNotNull(
        childIndex, r'AMPRecord', 'childIndex');
  }

  @override
  AMPRecord rebuild(void Function(AMPRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AMPRecordBuilder toBuilder() => AMPRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AMPRecord &&
        rootShare == other.rootShare &&
        setId == other.setId &&
        childIndex == other.childIndex;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rootShare.hashCode);
    _$hash = $jc(_$hash, setId.hashCode);
    _$hash = $jc(_$hash, childIndex.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AMPRecord')
          ..add('rootShare', rootShare)
          ..add('setId', setId)
          ..add('childIndex', childIndex))
        .toString();
  }
}

class AMPRecordBuilder implements Builder<AMPRecord, AMPRecordBuilder> {
  _$AMPRecord? _$v;

  String? _rootShare;
  String? get rootShare => _$this._rootShare;
  set rootShare(String? rootShare) => _$this._rootShare = rootShare;

  String? _setId;
  String? get setId => _$this._setId;
  set setId(String? setId) => _$this._setId = setId;

  int? _childIndex;
  int? get childIndex => _$this._childIndex;
  set childIndex(int? childIndex) => _$this._childIndex = childIndex;

  AMPRecordBuilder() {
    AMPRecord._defaults(this);
  }

  AMPRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rootShare = $v.rootShare;
      _setId = $v.setId;
      _childIndex = $v.childIndex;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AMPRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AMPRecord;
  }

  @override
  void update(void Function(AMPRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AMPRecord build() => _build();

  _$AMPRecord _build() {
    final _$result = _$v ??
        _$AMPRecord._(
            rootShare: BuiltValueNullFieldError.checkNotNull(
                rootShare, r'AMPRecord', 'rootShare'),
            setId: BuiltValueNullFieldError.checkNotNull(
                setId, r'AMPRecord', 'setId'),
            childIndex: BuiltValueNullFieldError.checkNotNull(
                childIndex, r'AMPRecord', 'childIndex'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
