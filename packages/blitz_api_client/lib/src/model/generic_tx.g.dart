// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_tx.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenericTx extends GenericTx {
  @override
  final int? index;
  @override
  final String id;
  @override
  final TxCategory? category;
  @override
  final TxType? type;
  @override
  final int amount;
  @override
  final int timeStamp;
  @override
  final String? comment;
  @override
  final TxStatus? status;
  @override
  final int? blockHeight;
  @override
  final int? numConfs;
  @override
  final int? totalFees;

  factory _$GenericTx([void Function(GenericTxBuilder)? updates]) =>
      (GenericTxBuilder()..update(updates))._build();

  _$GenericTx._(
      {this.index,
      required this.id,
      this.category,
      this.type,
      required this.amount,
      required this.timeStamp,
      this.comment,
      this.status,
      this.blockHeight,
      this.numConfs,
      this.totalFees})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GenericTx', 'id');
    BuiltValueNullFieldError.checkNotNull(amount, r'GenericTx', 'amount');
    BuiltValueNullFieldError.checkNotNull(timeStamp, r'GenericTx', 'timeStamp');
  }

  @override
  GenericTx rebuild(void Function(GenericTxBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenericTxBuilder toBuilder() => GenericTxBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenericTx &&
        index == other.index &&
        id == other.id &&
        category == other.category &&
        type == other.type &&
        amount == other.amount &&
        timeStamp == other.timeStamp &&
        comment == other.comment &&
        status == other.status &&
        blockHeight == other.blockHeight &&
        numConfs == other.numConfs &&
        totalFees == other.totalFees;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, index.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, timeStamp.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, blockHeight.hashCode);
    _$hash = $jc(_$hash, numConfs.hashCode);
    _$hash = $jc(_$hash, totalFees.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenericTx')
          ..add('index', index)
          ..add('id', id)
          ..add('category', category)
          ..add('type', type)
          ..add('amount', amount)
          ..add('timeStamp', timeStamp)
          ..add('comment', comment)
          ..add('status', status)
          ..add('blockHeight', blockHeight)
          ..add('numConfs', numConfs)
          ..add('totalFees', totalFees))
        .toString();
  }
}

class GenericTxBuilder implements Builder<GenericTx, GenericTxBuilder> {
  _$GenericTx? _$v;

  int? _index;
  int? get index => _$this._index;
  set index(int? index) => _$this._index = index;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  TxCategory? _category;
  TxCategory? get category => _$this._category;
  set category(TxCategory? category) => _$this._category = category;

  TxType? _type;
  TxType? get type => _$this._type;
  set type(TxType? type) => _$this._type = type;

  int? _amount;
  int? get amount => _$this._amount;
  set amount(int? amount) => _$this._amount = amount;

  int? _timeStamp;
  int? get timeStamp => _$this._timeStamp;
  set timeStamp(int? timeStamp) => _$this._timeStamp = timeStamp;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  TxStatus? _status;
  TxStatus? get status => _$this._status;
  set status(TxStatus? status) => _$this._status = status;

  int? _blockHeight;
  int? get blockHeight => _$this._blockHeight;
  set blockHeight(int? blockHeight) => _$this._blockHeight = blockHeight;

  int? _numConfs;
  int? get numConfs => _$this._numConfs;
  set numConfs(int? numConfs) => _$this._numConfs = numConfs;

  int? _totalFees;
  int? get totalFees => _$this._totalFees;
  set totalFees(int? totalFees) => _$this._totalFees = totalFees;

  GenericTxBuilder() {
    GenericTx._defaults(this);
  }

  GenericTxBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _index = $v.index;
      _id = $v.id;
      _category = $v.category;
      _type = $v.type;
      _amount = $v.amount;
      _timeStamp = $v.timeStamp;
      _comment = $v.comment;
      _status = $v.status;
      _blockHeight = $v.blockHeight;
      _numConfs = $v.numConfs;
      _totalFees = $v.totalFees;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenericTx other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GenericTx;
  }

  @override
  void update(void Function(GenericTxBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenericTx build() => _build();

  _$GenericTx _build() {
    final _$result = _$v ??
        _$GenericTx._(
            index: index,
            id: BuiltValueNullFieldError.checkNotNull(id, r'GenericTx', 'id'),
            category: category,
            type: type,
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'GenericTx', 'amount'),
            timeStamp: BuiltValueNullFieldError.checkNotNull(
                timeStamp, r'GenericTx', 'timeStamp'),
            comment: comment,
            status: status,
            blockHeight: blockHeight,
            numConfs: numConfs,
            totalFees: totalFees);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
