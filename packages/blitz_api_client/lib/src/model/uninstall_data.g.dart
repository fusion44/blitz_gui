// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uninstall_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UninstallData extends UninstallData {
  @override
  final bool? keepData;

  factory _$UninstallData([void Function(UninstallDataBuilder)? updates]) =>
      (UninstallDataBuilder()..update(updates))._build();

  _$UninstallData._({this.keepData}) : super._();

  @override
  UninstallData rebuild(void Function(UninstallDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UninstallDataBuilder toBuilder() => UninstallDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UninstallData && keepData == other.keepData;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, keepData.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UninstallData')
          ..add('keepData', keepData))
        .toString();
  }
}

class UninstallDataBuilder
    implements Builder<UninstallData, UninstallDataBuilder> {
  _$UninstallData? _$v;

  bool? _keepData;
  bool? get keepData => _$this._keepData;
  set keepData(bool? keepData) => _$this._keepData = keepData;

  UninstallDataBuilder() {
    UninstallData._defaults(this);
  }

  UninstallDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _keepData = $v.keepData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UninstallData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UninstallData;
  }

  @override
  void update(void Function(UninstallDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UninstallData build() => _build();

  _$UninstallData _build() {
    final _$result = _$v ?? _$UninstallData._(keepData: keepData);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
