// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_records_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CustomRecordsEntry extends CustomRecordsEntry {
  @override
  final int key;
  @override
  final String value;

  factory _$CustomRecordsEntry(
          [void Function(CustomRecordsEntryBuilder)? updates]) =>
      (CustomRecordsEntryBuilder()..update(updates))._build();

  _$CustomRecordsEntry._({required this.key, required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(key, r'CustomRecordsEntry', 'key');
    BuiltValueNullFieldError.checkNotNull(
        value, r'CustomRecordsEntry', 'value');
  }

  @override
  CustomRecordsEntry rebuild(
          void Function(CustomRecordsEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CustomRecordsEntryBuilder toBuilder() =>
      CustomRecordsEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CustomRecordsEntry &&
        key == other.key &&
        value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CustomRecordsEntry')
          ..add('key', key)
          ..add('value', value))
        .toString();
  }
}

class CustomRecordsEntryBuilder
    implements Builder<CustomRecordsEntry, CustomRecordsEntryBuilder> {
  _$CustomRecordsEntry? _$v;

  int? _key;
  int? get key => _$this._key;
  set key(int? key) => _$this._key = key;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  CustomRecordsEntryBuilder() {
    CustomRecordsEntry._defaults(this);
  }

  CustomRecordsEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _key = $v.key;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CustomRecordsEntry other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CustomRecordsEntry;
  }

  @override
  void update(void Function(CustomRecordsEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CustomRecordsEntry build() => _build();

  _$CustomRecordsEntry _build() {
    final _$result = _$v ??
        _$CustomRecordsEntry._(
            key: BuiltValueNullFieldError.checkNotNull(
                key, r'CustomRecordsEntry', 'key'),
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'CustomRecordsEntry', 'value'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
