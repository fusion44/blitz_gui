// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'on_chain_transaction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OnChainTransaction extends OnChainTransaction {
  @override
  final String txHash;
  @override
  final int amount;
  @override
  final int numConfirmations;
  @override
  final int blockHeight;
  @override
  final int timeStamp;
  @override
  final int totalFees;
  @override
  final BuiltList<String>? destAddresses;
  @override
  final String? label;

  factory _$OnChainTransaction(
          [void Function(OnChainTransactionBuilder)? updates]) =>
      (OnChainTransactionBuilder()..update(updates))._build();

  _$OnChainTransaction._(
      {required this.txHash,
      required this.amount,
      required this.numConfirmations,
      required this.blockHeight,
      required this.timeStamp,
      required this.totalFees,
      this.destAddresses,
      this.label})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        txHash, r'OnChainTransaction', 'txHash');
    BuiltValueNullFieldError.checkNotNull(
        amount, r'OnChainTransaction', 'amount');
    BuiltValueNullFieldError.checkNotNull(
        numConfirmations, r'OnChainTransaction', 'numConfirmations');
    BuiltValueNullFieldError.checkNotNull(
        blockHeight, r'OnChainTransaction', 'blockHeight');
    BuiltValueNullFieldError.checkNotNull(
        timeStamp, r'OnChainTransaction', 'timeStamp');
    BuiltValueNullFieldError.checkNotNull(
        totalFees, r'OnChainTransaction', 'totalFees');
  }

  @override
  OnChainTransaction rebuild(
          void Function(OnChainTransactionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OnChainTransactionBuilder toBuilder() =>
      OnChainTransactionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OnChainTransaction &&
        txHash == other.txHash &&
        amount == other.amount &&
        numConfirmations == other.numConfirmations &&
        blockHeight == other.blockHeight &&
        timeStamp == other.timeStamp &&
        totalFees == other.totalFees &&
        destAddresses == other.destAddresses &&
        label == other.label;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, numConfirmations.hashCode);
    _$hash = $jc(_$hash, blockHeight.hashCode);
    _$hash = $jc(_$hash, timeStamp.hashCode);
    _$hash = $jc(_$hash, totalFees.hashCode);
    _$hash = $jc(_$hash, destAddresses.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OnChainTransaction')
          ..add('txHash', txHash)
          ..add('amount', amount)
          ..add('numConfirmations', numConfirmations)
          ..add('blockHeight', blockHeight)
          ..add('timeStamp', timeStamp)
          ..add('totalFees', totalFees)
          ..add('destAddresses', destAddresses)
          ..add('label', label))
        .toString();
  }
}

class OnChainTransactionBuilder
    implements Builder<OnChainTransaction, OnChainTransactionBuilder> {
  _$OnChainTransaction? _$v;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  int? _numConfirmations;
  int? get numConfirmations => _$this._numConfirmations;
  set numConfirmations(int? numConfirmations) =>
      _$this._numConfirmations = numConfirmations;

  int? _blockHeight;
  int? get blockHeight => _$this._blockHeight;
  set blockHeight(int? blockHeight) => _$this._blockHeight = blockHeight;

  int? _timeStamp;
  int? get timeStamp => _$this._timeStamp;
  set timeStamp(int? timeStamp) => _$this._timeStamp = timeStamp;

  int? _totalFees;
  int? get totalFees => _$this._totalFees;
  set totalFees(int? totalFees) => _$this._totalFees = totalFees;

  ListBuilder<String>? _destAddresses;
  ListBuilder<String> get destAddresses =>
      _$this._destAddresses ??= ListBuilder<String>();
  set destAddresses(ListBuilder<String>? destAddresses) =>
      _$this._destAddresses = destAddresses;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  OnChainTransactionBuilder() {
    OnChainTransaction._defaults(this);
  }

  OnChainTransactionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _txHash = $v.txHash;
      _amount = $v.amount;
      _numConfirmations = $v.numConfirmations;
      _blockHeight = $v.blockHeight;
      _timeStamp = $v.timeStamp;
      _totalFees = $v.totalFees;
      _destAddresses = $v.destAddresses?.toBuilder();
      _label = $v.label;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OnChainTransaction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OnChainTransaction;
  }

  @override
  void update(void Function(OnChainTransactionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OnChainTransaction build() => _build();

  _$OnChainTransaction _build() {
    _$OnChainTransaction _$result;
    try {
      _$result = _$v ??
          _$OnChainTransaction._(
              txHash: BuiltValueNullFieldError.checkNotNull(
                  txHash, r'OnChainTransaction', 'txHash'),
              amount: BuiltValueNullFieldError.checkNotNull(
                  amount, r'OnChainTransaction', 'amount'),
              numConfirmations: BuiltValueNullFieldError.checkNotNull(
                  numConfirmations, r'OnChainTransaction', 'numConfirmations'),
              blockHeight: BuiltValueNullFieldError.checkNotNull(
                  blockHeight, r'OnChainTransaction', 'blockHeight'),
              timeStamp: BuiltValueNullFieldError.checkNotNull(
                  timeStamp, r'OnChainTransaction', 'timeStamp'),
              totalFees: BuiltValueNullFieldError.checkNotNull(
                  totalFees, r'OnChainTransaction', 'totalFees'),
              destAddresses: _destAddresses?.build(),
              label: label);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'destAddresses';
        _destAddresses?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'OnChainTransaction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
