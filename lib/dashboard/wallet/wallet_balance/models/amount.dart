class Amount {
  final int sat;
  final int msat;

  const Amount({this.sat = 0, this.msat = 0});

  static Amount fromJson(Map<String, dynamic> json) {
    return Amount(
      sat: json['sat'],
      msat: json['msat'],
    );
  }

  static Amount fromSats(int sats) => Amount(sat: sats, msat: sats * 1000);
}
