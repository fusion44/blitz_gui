import '../utils.dart';

/// A class that represents a value in Bitcoin.
class BtcValue {
  // totals
  final double btcTotal;
  final int satsTotal;
  final int msatTotal;

  BtcValue._({
    required this.satsTotal,
    required this.msatTotal,
    required this.btcTotal,
  });

  /// Creates a new [BitcoinValue] object from an integer value in msats.
  ///
  /// The [msats] parameter is the value in millisatoshis, which is
  /// 1/1000th of a satoshi. The [fromMilliSat] constructor calculates
  /// the corresponding values in sats and BTC. The sat and btc will be rounded
  /// from the msat value.

  factory BtcValue.fromMilliSat(int msats) {
    // we assume that when we construct from a msat value,
    // we will receive the trailing 000s even if there are no
    // actual msats in the value.

    return BtcValue._(
      satsTotal: msats ~/ 1000,
      msatTotal: msats,
      btcTotal: msats / 1e11,
    );
  }

  /// Creates a new [BitcoinValue] object from an integer value in sats.
  ///
  /// The [sats] parameter is the value in satoshis, which is the smallest
  /// unit of Bitcoin. The [fromSats] constructor calculates the corresponding
  /// values in msats (1/1000th of a satoshi) and BTC.
  factory BtcValue.fromSats(int sats) {
    return BtcValue._(
      satsTotal: sats,
      msatTotal: sats * 1000,
      btcTotal: sats / 1e8,
    );
  }

  /// Creates a new [BitcoinValue] object from a double value in BTC.
  ///
  /// The [btc] parameter is the value in Bitcoin. The [fromBtc] constructor
  /// calculates the corresponding values in sats and msats.
  factory BtcValue.fromBtc(double btc) {
    final frac = btc.toString().split(".");
    if (frac[1].length > 8) {
      throw ArgumentError("Too many decimal places in $btc");
    }

    return BtcValue._(
      satsTotal: (btc * 1e8).round(),
      msatTotal: (btc * 1e11).round(),
      btcTotal: btc,
    );
  }

  factory BtcValue.zero() => BtcValue._(
        satsTotal: 0,
        msatTotal: 0,
        btcTotal: 0,
      );

  /// The btc part only of the value.
  ///
  /// For example, if the value is 11btc 12,345,678sats
  /// and 912 msats, this will return 11.
  int get btc {
    // if we only have a few msats, we don't have any btc
    if (msatTotal < 100000000000) return 0;

    final btc = msatTotal.toString();
    final length = btc.length;

    return int.parse(btc.substring(0, length - 11));
  }

  /// The sats part only of the value.
  ///
  /// For example, if the value is 11btc 12,345,678sats
  /// and 912 msats, this will return 12345678.
  int get sats {
    // if we only have a few msats, we don't have any sats
    if (msatTotal < 1000) return 0;

    final msat = msatTotal.toString();
    final length = msat.length;

    int start = 0;
    if (msatTotal >= 100000000000) start = length - 11;

    return int.parse(msat.substring(start, length - 3));
  }

  /// The sats part only of the value.
  ///
  /// For example, if the value is 11btc 12,345,678sats
  /// and 912 msats, this will return 912.
  int get msat {
    if (msatTotal < 1000) return msatTotal;

    final msatsStr = msatTotal.toString();
    return int.parse(msatsStr.substring(msatsStr.length - 3));
  }

  bool get hasMsats {
    if (msatTotal == 0) return false;

    return !msatTotal.toString().endsWith("000");
  }

  String formatted({String msatDelimiter = ' ', String btcDelimiter = '.'}) {
    // 1.12345678123
    // 1.87654321000

    if (btcTotal == 0) return '0';
    String fracFormatted = msatTotal.toString().padLeft(11, "0");
    fracFormatted = fracFormatted.insertCharAtPosition(-3, msatDelimiter);
    fracFormatted = fracFormatted.insertCharAtPosition(-7, ',');
    fracFormatted = fracFormatted.insertCharAtPosition(-11, ',');
    if (btcTotal >= 1) {
      fracFormatted = fracFormatted.insertCharAtPosition(-14, btcDelimiter);
    }

    return fracFormatted;
  }

  BtcValue operator +(BtcValue other) {
    final int newMsats = msatTotal + other.msatTotal;

    return BtcValue.fromMilliSat(newMsats);
  }

  BtcValue operator -(BtcValue other) {
    final int newMsats = msatTotal - other.msatTotal;

    return BtcValue.fromMilliSat(newMsats);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BtcValue &&
          runtimeType == other.runtimeType &&
          msatTotal == other.msatTotal;

  @override
  int get hashCode =>
      satsTotal.hashCode ^ msatTotal.hashCode ^ btcTotal.hashCode;

  @override
  String toString() {
    return 'Bitcoin(sats: $satsTotal, msats: $msatTotal, btc: $btcTotal)';
  }
}
