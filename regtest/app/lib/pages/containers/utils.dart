import 'package:regtest_core/core.dart';

String getContainerLogo(ContainerType type) => switch (type) {
      ContainerType.bitcoinCore => 'assets/images/bitcoin_core_logo.png',
      ContainerType.lnd => 'assets/images/lnd_logo.png',
      ContainerType.cln => 'assets/images/cln_logo.png',
      ContainerType.lnbits => 'assets/images/lnbits_logo.png',
      ContainerType.cashuMint => 'assets/images/cashu_logo.png'
    };
