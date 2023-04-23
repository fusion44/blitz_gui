// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'features_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FeaturesEntry extends FeaturesEntry {
  @override
  final int key;
  @override
  final Feature value;

  factory _$FeaturesEntry([void Function(FeaturesEntryBuilder)? updates]) =>
      (FeaturesEntryBuilder()..update(updates))._build();

  _$FeaturesEntry._({required this.key, required this.value}) : super._() {
    BuiltValueNullFieldError.checkNotNull(key, r'FeaturesEntry', 'key');
    BuiltValueNullFieldError.checkNotNull(value, r'FeaturesEntry', 'value');
  }

  @override
  FeaturesEntry rebuild(void Function(FeaturesEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeaturesEntryBuilder toBuilder() => FeaturesEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeaturesEntry && key == other.key && value == other.value;
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
    return (newBuiltValueToStringHelper(r'FeaturesEntry')
          ..add('key', key)
          ..add('value', value))
        .toString();
  }
}

class FeaturesEntryBuilder
    implements Builder<FeaturesEntry, FeaturesEntryBuilder> {
  _$FeaturesEntry? _$v;

  int? _key;
  int? get key => _$this._key;
  set key(int? key) => _$this._key = key;

  FeatureBuilder? _value;
  FeatureBuilder get value => _$this._value ??= FeatureBuilder();
  set value(FeatureBuilder? value) => _$this._value = value;

  FeaturesEntryBuilder() {
    FeaturesEntry._defaults(this);
  }

  FeaturesEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _key = $v.key;
      _value = $v.value.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeaturesEntry other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FeaturesEntry;
  }

  @override
  void update(void Function(FeaturesEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FeaturesEntry build() => _build();

  _$FeaturesEntry _build() {
    _$FeaturesEntry _$result;
    try {
      _$result = _$v ??
          _$FeaturesEntry._(
              key: BuiltValueNullFieldError.checkNotNull(
                  key, r'FeaturesEntry', 'key'),
              value: value.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'value';
        value.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FeaturesEntry', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
