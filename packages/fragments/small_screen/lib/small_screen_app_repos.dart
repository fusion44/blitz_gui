import 'package:flutter/material.dart';

import 'package:authentication/authentication.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_transactions_fragment/list_transactions.dart';
import 'package:settings_fragment/settings_fragment.dart';
import 'package:subscription_repository/subscription_repository.dart';

class SmallScreenAppRepos {
  final AuthRepo authRepo;
  final BitcoinInfoBloc btcInfoBloc;
  final HardwareInfoBloc hardwareBloc;
  final LightningInfoBloc lnInfoBloc;
  final ListTxBloc listTxBloc;
  final SettingsBloc settingsBloc;
  final SubscriptionRepository subRepo;
  final SystemInfoBloc systemBloc;
  final WalletLockedCheckerBloc walletLockedChecker;

  SmallScreenAppRepos({
    required this.authRepo,
    required this.btcInfoBloc,
    required this.hardwareBloc,
    required this.listTxBloc,
    required this.lnInfoBloc,
    required this.settingsBloc,
    required this.subRepo,
    required this.systemBloc,
    required this.walletLockedChecker,
  });

  Widget provide({required Widget child}) {
    final repos = MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: subRepo),
      ],
      child: child,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<BitcoinInfoBloc>.value(value: btcInfoBloc),
        BlocProvider<HardwareInfoBloc>.value(value: hardwareBloc),
        BlocProvider<LightningInfoBloc>.value(value: lnInfoBloc),
        BlocProvider<ListTxBloc>.value(value: listTxBloc),
        BlocProvider<SettingsBloc>.value(value: settingsBloc),
        BlocProvider<SystemInfoBloc>.value(value: systemBloc),
        BlocProvider<WalletLockedCheckerBloc>.value(value: walletLockedChecker),
      ],
      child: repos,
    );
  }

  void dispose() async {
    await listTxBloc.dispose();
    btcInfoBloc.add(StopListenBitcoinInfo());
    hardwareBloc.add(StopListenHardwareInfo());
    lnInfoBloc.add(StopListenLightningInfo());
    systemBloc.add(StopListenSystemInfo());
  }
}
