// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_hint.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RouteHint extends RouteHint {
  @override
  final BuiltList<HopHint>? hopHints;

  factory _$RouteHint([void Function(RouteHintBuilder)? updates]) =>
      (RouteHintBuilder()..update(updates))._build();

  _$RouteHint._({this.hopHints}) : super._();

  @override
  RouteHint rebuild(void Function(RouteHintBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RouteHintBuilder toBuilder() => RouteHintBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RouteHint && hopHints == other.hopHints;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, hopHints.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RouteHint')
          ..add('hopHints', hopHints))
        .toString();
  }
}

class RouteHintBuilder implements Builder<RouteHint, RouteHintBuilder> {
  _$RouteHint? _$v;

  ListBuilder<HopHint>? _hopHints;
  ListBuilder<HopHint> get hopHints =>
      _$this._hopHints ??= ListBuilder<HopHint>();
  set hopHints(ListBuilder<HopHint>? hopHints) => _$this._hopHints = hopHints;

  RouteHintBuilder() {
    RouteHint._defaults(this);
  }

  RouteHintBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _hopHints = $v.hopHints?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RouteHint other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RouteHint;
  }

  @override
  void update(void Function(RouteHintBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RouteHint build() => _build();

  _$RouteHint _build() {
    _$RouteHint _$result;
    try {
      _$result = _$v ?? _$RouteHint._(hopHints: _hopHints?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'hopHints';
        _hopHints?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RouteHint', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
