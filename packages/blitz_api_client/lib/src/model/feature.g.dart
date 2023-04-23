// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Feature extends Feature {
  @override
  final String name;
  @override
  final bool? isRequired;
  @override
  final bool? isKnown;

  factory _$Feature([void Function(FeatureBuilder)? updates]) =>
      (FeatureBuilder()..update(updates))._build();

  _$Feature._({required this.name, this.isRequired, this.isKnown}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'Feature', 'name');
  }

  @override
  Feature rebuild(void Function(FeatureBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeatureBuilder toBuilder() => FeatureBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Feature &&
        name == other.name &&
        isRequired == other.isRequired &&
        isKnown == other.isKnown;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, isRequired.hashCode);
    _$hash = $jc(_$hash, isKnown.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Feature')
          ..add('name', name)
          ..add('isRequired', isRequired)
          ..add('isKnown', isKnown))
        .toString();
  }
}

class FeatureBuilder implements Builder<Feature, FeatureBuilder> {
  _$Feature? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  bool? _isRequired;
  bool? get isRequired => _$this._isRequired;
  set isRequired(bool? isRequired) => _$this._isRequired = isRequired;

  bool? _isKnown;
  bool? get isKnown => _$this._isKnown;
  set isKnown(bool? isKnown) => _$this._isKnown = isKnown;

  FeatureBuilder() {
    Feature._defaults(this);
  }

  FeatureBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _isRequired = $v.isRequired;
      _isKnown = $v.isKnown;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Feature other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Feature;
  }

  @override
  void update(void Function(FeatureBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Feature build() => _build();

  _$Feature _build() {
    final _$result = _$v ??
        _$Feature._(
            name:
                BuiltValueNullFieldError.checkNotNull(name, r'Feature', 'name'),
            isRequired: isRequired,
            isKnown: isKnown);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
