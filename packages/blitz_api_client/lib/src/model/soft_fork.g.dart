// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'soft_fork.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SoftFork extends SoftFork {
  @override
  final String name;
  @override
  final String type;
  @override
  final bool active;
  @override
  final Bip9? bip9;
  @override
  final int? height;

  factory _$SoftFork([void Function(SoftForkBuilder)? updates]) =>
      (SoftForkBuilder()..update(updates))._build();

  _$SoftFork._(
      {required this.name,
      required this.type,
      required this.active,
      this.bip9,
      this.height})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'SoftFork', 'name');
    BuiltValueNullFieldError.checkNotNull(type, r'SoftFork', 'type');
    BuiltValueNullFieldError.checkNotNull(active, r'SoftFork', 'active');
  }

  @override
  SoftFork rebuild(void Function(SoftForkBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SoftForkBuilder toBuilder() => SoftForkBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SoftFork &&
        name == other.name &&
        type == other.type &&
        active == other.active &&
        bip9 == other.bip9 &&
        height == other.height;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, active.hashCode);
    _$hash = $jc(_$hash, bip9.hashCode);
    _$hash = $jc(_$hash, height.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SoftFork')
          ..add('name', name)
          ..add('type', type)
          ..add('active', active)
          ..add('bip9', bip9)
          ..add('height', height))
        .toString();
  }
}

class SoftForkBuilder implements Builder<SoftFork, SoftForkBuilder> {
  _$SoftFork? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  bool? _active;
  bool? get active => _$this._active;
  set active(bool? active) => _$this._active = active;

  Bip9Builder? _bip9;
  Bip9Builder get bip9 => _$this._bip9 ??= Bip9Builder();
  set bip9(Bip9Builder? bip9) => _$this._bip9 = bip9;

  int? _height;
  int? get height => _$this._height;
  set height(int? height) => _$this._height = height;

  SoftForkBuilder() {
    SoftFork._defaults(this);
  }

  SoftForkBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _type = $v.type;
      _active = $v.active;
      _bip9 = $v.bip9?.toBuilder();
      _height = $v.height;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SoftFork other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SoftFork;
  }

  @override
  void update(void Function(SoftForkBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SoftFork build() => _build();

  _$SoftFork _build() {
    _$SoftFork _$result;
    try {
      _$result = _$v ??
          _$SoftFork._(
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'SoftFork', 'name'),
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'SoftFork', 'type'),
              active: BuiltValueNullFieldError.checkNotNull(
                  active, r'SoftFork', 'active'),
              bip9: _bip9?.build(),
              height: height);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'bip9';
        _bip9?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SoftFork', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
