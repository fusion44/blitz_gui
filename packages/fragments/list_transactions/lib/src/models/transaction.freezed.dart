// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TransactionTearOff {
  const _$TransactionTearOff();

  _Transaction call(
      {required int index,
      required String id,
      required TxCategory category,
      required TxType type,
      required int amount,
      required DateTime timeStamp,
      required String comment,
      required TxStatus status,
      int blockHeight = 0,
      int numConfs = 0,
      int totalFees = 0}) {
    return _Transaction(
      index: index,
      id: id,
      category: category,
      type: type,
      amount: amount,
      timeStamp: timeStamp,
      comment: comment,
      status: status,
      blockHeight: blockHeight,
      numConfs: numConfs,
      totalFees: totalFees,
    );
  }
}

/// @nodoc
const $Transaction = _$TransactionTearOff();

/// @nodoc
mixin _$Transaction {
  int get index => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  TxCategory get category => throw _privateConstructorUsedError;
  TxType get type => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  DateTime get timeStamp => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  TxStatus get status => throw _privateConstructorUsedError;
  int get blockHeight => throw _privateConstructorUsedError;
  int get numConfs => throw _privateConstructorUsedError;
  int get totalFees => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res>;
  $Res call(
      {int index,
      String id,
      TxCategory category,
      TxType type,
      int amount,
      DateTime timeStamp,
      String comment,
      TxStatus status,
      int blockHeight,
      int numConfs,
      int totalFees});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res> implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  final Transaction _value;
  // ignore: unused_field
  final $Res Function(Transaction) _then;

  @override
  $Res call({
    Object? index = freezed,
    Object? id = freezed,
    Object? category = freezed,
    Object? type = freezed,
    Object? amount = freezed,
    Object? timeStamp = freezed,
    Object? comment = freezed,
    Object? status = freezed,
    Object? blockHeight = freezed,
    Object? numConfs = freezed,
    Object? totalFees = freezed,
  }) {
    return _then(_value.copyWith(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TxCategory,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TxType,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      timeStamp: timeStamp == freezed
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TxStatus,
      blockHeight: blockHeight == freezed
          ? _value.blockHeight
          : blockHeight // ignore: cast_nullable_to_non_nullable
              as int,
      numConfs: numConfs == freezed
          ? _value.numConfs
          : numConfs // ignore: cast_nullable_to_non_nullable
              as int,
      totalFees: totalFees == freezed
          ? _value.totalFees
          : totalFees // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$TransactionCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(
          _Transaction value, $Res Function(_Transaction) then) =
      __$TransactionCopyWithImpl<$Res>;
  @override
  $Res call(
      {int index,
      String id,
      TxCategory category,
      TxType type,
      int amount,
      DateTime timeStamp,
      String comment,
      TxStatus status,
      int blockHeight,
      int numConfs,
      int totalFees});
}

/// @nodoc
class __$TransactionCopyWithImpl<$Res> extends _$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(
      _Transaction _value, $Res Function(_Transaction) _then)
      : super(_value, (v) => _then(v as _Transaction));

  @override
  _Transaction get _value => super._value as _Transaction;

  @override
  $Res call({
    Object? index = freezed,
    Object? id = freezed,
    Object? category = freezed,
    Object? type = freezed,
    Object? amount = freezed,
    Object? timeStamp = freezed,
    Object? comment = freezed,
    Object? status = freezed,
    Object? blockHeight = freezed,
    Object? numConfs = freezed,
    Object? totalFees = freezed,
  }) {
    return _then(_Transaction(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as TxCategory,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TxType,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      timeStamp: timeStamp == freezed
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TxStatus,
      blockHeight: blockHeight == freezed
          ? _value.blockHeight
          : blockHeight // ignore: cast_nullable_to_non_nullable
              as int,
      numConfs: numConfs == freezed
          ? _value.numConfs
          : numConfs // ignore: cast_nullable_to_non_nullable
              as int,
      totalFees: totalFees == freezed
          ? _value.totalFees
          : totalFees // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Transaction extends _Transaction {
  const _$_Transaction(
      {required this.index,
      required this.id,
      required this.category,
      required this.type,
      required this.amount,
      required this.timeStamp,
      required this.comment,
      required this.status,
      this.blockHeight = 0,
      this.numConfs = 0,
      this.totalFees = 0})
      : super._();

  @override
  final int index;
  @override
  final String id;
  @override
  final TxCategory category;
  @override
  final TxType type;
  @override
  final int amount;
  @override
  final DateTime timeStamp;
  @override
  final String comment;
  @override
  final TxStatus status;
  @JsonKey()
  @override
  final int blockHeight;
  @JsonKey()
  @override
  final int numConfs;
  @JsonKey()
  @override
  final int totalFees;

  @override
  String toString() {
    return 'Transaction(index: $index, id: $id, category: $category, type: $type, amount: $amount, timeStamp: $timeStamp, comment: $comment, status: $status, blockHeight: $blockHeight, numConfs: $numConfs, totalFees: $totalFees)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Transaction &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality().equals(other.timeStamp, timeStamp) &&
            const DeepCollectionEquality().equals(other.comment, comment) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.blockHeight, blockHeight) &&
            const DeepCollectionEquality().equals(other.numConfs, numConfs) &&
            const DeepCollectionEquality().equals(other.totalFees, totalFees));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(timeStamp),
      const DeepCollectionEquality().hash(comment),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(blockHeight),
      const DeepCollectionEquality().hash(numConfs),
      const DeepCollectionEquality().hash(totalFees));

  @JsonKey(ignore: true)
  @override
  _$TransactionCopyWith<_Transaction> get copyWith =>
      __$TransactionCopyWithImpl<_Transaction>(this, _$identity);
}

abstract class _Transaction extends Transaction {
  const factory _Transaction(
      {required int index,
      required String id,
      required TxCategory category,
      required TxType type,
      required int amount,
      required DateTime timeStamp,
      required String comment,
      required TxStatus status,
      int blockHeight,
      int numConfs,
      int totalFees}) = _$_Transaction;
  const _Transaction._() : super._();

  @override
  int get index;
  @override
  String get id;
  @override
  TxCategory get category;
  @override
  TxType get type;
  @override
  int get amount;
  @override
  DateTime get timeStamp;
  @override
  String get comment;
  @override
  TxStatus get status;
  @override
  int get blockHeight;
  @override
  int get numConfs;
  @override
  int get totalFees;
  @override
  @JsonKey(ignore: true)
  _$TransactionCopyWith<_Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}
