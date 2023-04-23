// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_address_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NewAddressInput extends NewAddressInput {
  @override
  final OnchainAddressType? type;

  factory _$NewAddressInput([void Function(NewAddressInputBuilder)? updates]) =>
      (NewAddressInputBuilder()..update(updates))._build();

  _$NewAddressInput._({this.type}) : super._();

  @override
  NewAddressInput rebuild(void Function(NewAddressInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewAddressInputBuilder toBuilder() => NewAddressInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewAddressInput && type == other.type;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NewAddressInput')..add('type', type))
        .toString();
  }
}

class NewAddressInputBuilder
    implements Builder<NewAddressInput, NewAddressInputBuilder> {
  _$NewAddressInput? _$v;

  OnchainAddressType? _type;
  OnchainAddressType? get type => _$this._type;
  set type(OnchainAddressType? type) => _$this._type = type;

  NewAddressInputBuilder() {
    NewAddressInput._defaults(this);
  }

  NewAddressInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewAddressInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NewAddressInput;
  }

  @override
  void update(void Function(NewAddressInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NewAddressInput build() => _build();

  _$NewAddressInput _build() {
    final _$result = _$v ?? _$NewAddressInput._(type: type);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
