import 'dart:convert';
import 'dart:ui';

import 'package:regtest_core/core.dart';

String getContainerLogo(ContainerType type) => switch (type) {
      ContainerType.bitcoinCore => 'assets/images/bitcoin_core_logo.png',
      ContainerType.blitzAPI => '',
      ContainerType.cashuMint => 'assets/images/cashu_logo.png',
      ContainerType.cln => 'assets/images/cln_logo.png',
      ContainerType.fakeLn => '',
      ContainerType.lnbits => 'assets/images/lnbits_logo.png',
      ContainerType.lnd => 'assets/images/lnd_logo.png',
      ContainerType.redis => '',
    };

extension OffsetExtension on Offset {
  static Offset fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);
    return Offset(data['dx'], data['dy']);
  }

  String toJson() => jsonEncode({'dx': dx, 'dy': dy});
}
