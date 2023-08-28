class Amount {
  final int sat;
  final int msat;

  const Amount({this.sat = 0, this.msat = 0});

  Amount operator +(Amount other) {
    return Amount(
      sat: this.sat + other.sat,
      msat: this.msat + other.msat,
    );
  }

  Amount operator -(Amount other) {
    return Amount(
      sat: this.sat - other.sat,
      msat: this.msat - other.msat,
    );
  }

  double get inBitcoin => sat / 100000000.0;

  static Amount fromJson(Map<String, dynamic> json) {
    return Amount(
      sat: json['sat'],
      msat: json['msat'],
    );
  }

  static Amount fromSats(int sats) => Amount(sat: sats, msat: sats * 1000);
  static Amount fromMSats(int mSats) => Amount(sat: mSats ~/ 1000, msat: mSats);
}
