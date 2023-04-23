// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_update.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChannelUpdate extends ChannelUpdate {
  @override
  final String signature;
  @override
  final String chainHash;
  @override
  final int chanId;
  @override
  final int timestamp;
  @override
  final int messageFlags;
  @override
  final int channelFlags;
  @override
  final int timeLockDelta;
  @override
  final int htlcMinimumMsat;
  @override
  final int baseFee;
  @override
  final int feeRate;
  @override
  final int htlcMaximumMsat;
  @override
  final String extraOpaqueData;

  factory _$ChannelUpdate([void Function(ChannelUpdateBuilder)? updates]) =>
      (ChannelUpdateBuilder()..update(updates))._build();

  _$ChannelUpdate._(
      {required this.signature,
      required this.chainHash,
      required this.chanId,
      required this.timestamp,
      required this.messageFlags,
      required this.channelFlags,
      required this.timeLockDelta,
      required this.htlcMinimumMsat,
      required this.baseFee,
      required this.feeRate,
      required this.htlcMaximumMsat,
      required this.extraOpaqueData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        signature, r'ChannelUpdate', 'signature');
    BuiltValueNullFieldError.checkNotNull(
        chainHash, r'ChannelUpdate', 'chainHash');
    BuiltValueNullFieldError.checkNotNull(chanId, r'ChannelUpdate', 'chanId');
    BuiltValueNullFieldError.checkNotNull(
        timestamp, r'ChannelUpdate', 'timestamp');
    BuiltValueNullFieldError.checkNotNull(
        messageFlags, r'ChannelUpdate', 'messageFlags');
    BuiltValueNullFieldError.checkNotNull(
        channelFlags, r'ChannelUpdate', 'channelFlags');
    BuiltValueNullFieldError.checkNotNull(
        timeLockDelta, r'ChannelUpdate', 'timeLockDelta');
    BuiltValueNullFieldError.checkNotNull(
        htlcMinimumMsat, r'ChannelUpdate', 'htlcMinimumMsat');
    BuiltValueNullFieldError.checkNotNull(baseFee, r'ChannelUpdate', 'baseFee');
    BuiltValueNullFieldError.checkNotNull(feeRate, r'ChannelUpdate', 'feeRate');
    BuiltValueNullFieldError.checkNotNull(
        htlcMaximumMsat, r'ChannelUpdate', 'htlcMaximumMsat');
    BuiltValueNullFieldError.checkNotNull(
        extraOpaqueData, r'ChannelUpdate', 'extraOpaqueData');
  }

  @override
  ChannelUpdate rebuild(void Function(ChannelUpdateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChannelUpdateBuilder toBuilder() => ChannelUpdateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChannelUpdate &&
        signature == other.signature &&
        chainHash == other.chainHash &&
        chanId == other.chanId &&
        timestamp == other.timestamp &&
        messageFlags == other.messageFlags &&
        channelFlags == other.channelFlags &&
        timeLockDelta == other.timeLockDelta &&
        htlcMinimumMsat == other.htlcMinimumMsat &&
        baseFee == other.baseFee &&
        feeRate == other.feeRate &&
        htlcMaximumMsat == other.htlcMaximumMsat &&
        extraOpaqueData == other.extraOpaqueData;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, signature.hashCode);
    _$hash = $jc(_$hash, chainHash.hashCode);
    _$hash = $jc(_$hash, chanId.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, messageFlags.hashCode);
    _$hash = $jc(_$hash, channelFlags.hashCode);
    _$hash = $jc(_$hash, timeLockDelta.hashCode);
    _$hash = $jc(_$hash, htlcMinimumMsat.hashCode);
    _$hash = $jc(_$hash, baseFee.hashCode);
    _$hash = $jc(_$hash, feeRate.hashCode);
    _$hash = $jc(_$hash, htlcMaximumMsat.hashCode);
    _$hash = $jc(_$hash, extraOpaqueData.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChannelUpdate')
          ..add('signature', signature)
          ..add('chainHash', chainHash)
          ..add('chanId', chanId)
          ..add('timestamp', timestamp)
          ..add('messageFlags', messageFlags)
          ..add('channelFlags', channelFlags)
          ..add('timeLockDelta', timeLockDelta)
          ..add('htlcMinimumMsat', htlcMinimumMsat)
          ..add('baseFee', baseFee)
          ..add('feeRate', feeRate)
          ..add('htlcMaximumMsat', htlcMaximumMsat)
          ..add('extraOpaqueData', extraOpaqueData))
        .toString();
  }
}

class ChannelUpdateBuilder
    implements Builder<ChannelUpdate, ChannelUpdateBuilder> {
  _$ChannelUpdate? _$v;

  String? _signature;
  String? get signature => _$this._signature;
  set signature(String? signature) => _$this._signature = signature;

  String? _chainHash;
  String? get chainHash => _$this._chainHash;
  set chainHash(String? chainHash) => _$this._chainHash = chainHash;

  int? _chanId;
  int? get chanId => _$this._chanId;
  set chanId(int? chanId) => _$this._chanId = chanId;

  int? _timestamp;
  int? get timestamp => _$this._timestamp;
  set timestamp(int? timestamp) => _$this._timestamp = timestamp;

  int? _messageFlags;
  int? get messageFlags => _$this._messageFlags;
  set messageFlags(int? messageFlags) => _$this._messageFlags = messageFlags;

  int? _channelFlags;
  int? get channelFlags => _$this._channelFlags;
  set channelFlags(int? channelFlags) => _$this._channelFlags = channelFlags;

  int? _timeLockDelta;
  int? get timeLockDelta => _$this._timeLockDelta;
  set timeLockDelta(int? timeLockDelta) =>
      _$this._timeLockDelta = timeLockDelta;

  int? _htlcMinimumMsat;
  int? get htlcMinimumMsat => _$this._htlcMinimumMsat;
  set htlcMinimumMsat(int? htlcMinimumMsat) =>
      _$this._htlcMinimumMsat = htlcMinimumMsat;

  int? _baseFee;
  int? get baseFee => _$this._baseFee;
  set baseFee(int? baseFee) => _$this._baseFee = baseFee;

  int? _feeRate;
  int? get feeRate => _$this._feeRate;
  set feeRate(int? feeRate) => _$this._feeRate = feeRate;

  int? _htlcMaximumMsat;
  int? get htlcMaximumMsat => _$this._htlcMaximumMsat;
  set htlcMaximumMsat(int? htlcMaximumMsat) =>
      _$this._htlcMaximumMsat = htlcMaximumMsat;

  String? _extraOpaqueData;
  String? get extraOpaqueData => _$this._extraOpaqueData;
  set extraOpaqueData(String? extraOpaqueData) =>
      _$this._extraOpaqueData = extraOpaqueData;

  ChannelUpdateBuilder() {
    ChannelUpdate._defaults(this);
  }

  ChannelUpdateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _signature = $v.signature;
      _chainHash = $v.chainHash;
      _chanId = $v.chanId;
      _timestamp = $v.timestamp;
      _messageFlags = $v.messageFlags;
      _channelFlags = $v.channelFlags;
      _timeLockDelta = $v.timeLockDelta;
      _htlcMinimumMsat = $v.htlcMinimumMsat;
      _baseFee = $v.baseFee;
      _feeRate = $v.feeRate;
      _htlcMaximumMsat = $v.htlcMaximumMsat;
      _extraOpaqueData = $v.extraOpaqueData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChannelUpdate other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChannelUpdate;
  }

  @override
  void update(void Function(ChannelUpdateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChannelUpdate build() => _build();

  _$ChannelUpdate _build() {
    final _$result = _$v ??
        _$ChannelUpdate._(
            signature: BuiltValueNullFieldError.checkNotNull(
                signature, r'ChannelUpdate', 'signature'),
            chainHash: BuiltValueNullFieldError.checkNotNull(
                chainHash, r'ChannelUpdate', 'chainHash'),
            chanId: BuiltValueNullFieldError.checkNotNull(
                chanId, r'ChannelUpdate', 'chanId'),
            timestamp: BuiltValueNullFieldError.checkNotNull(
                timestamp, r'ChannelUpdate', 'timestamp'),
            messageFlags: BuiltValueNullFieldError.checkNotNull(
                messageFlags, r'ChannelUpdate', 'messageFlags'),
            channelFlags: BuiltValueNullFieldError.checkNotNull(
                channelFlags, r'ChannelUpdate', 'channelFlags'),
            timeLockDelta: BuiltValueNullFieldError.checkNotNull(
                timeLockDelta, r'ChannelUpdate', 'timeLockDelta'),
            htlcMinimumMsat: BuiltValueNullFieldError.checkNotNull(
                htlcMinimumMsat, r'ChannelUpdate', 'htlcMinimumMsat'),
            baseFee: BuiltValueNullFieldError.checkNotNull(
                baseFee, r'ChannelUpdate', 'baseFee'),
            feeRate: BuiltValueNullFieldError.checkNotNull(feeRate, r'ChannelUpdate', 'feeRate'),
            htlcMaximumMsat: BuiltValueNullFieldError.checkNotNull(htlcMaximumMsat, r'ChannelUpdate', 'htlcMaximumMsat'),
            extraOpaqueData: BuiltValueNullFieldError.checkNotNull(extraOpaqueData, r'ChannelUpdate', 'extraOpaqueData'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
