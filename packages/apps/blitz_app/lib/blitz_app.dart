import 'package:flutter/material.dart';

import 'package:authentication/authentication.dart';
import 'package:big_screen/big_screen.dart';
import 'package:big_screen/big_screen_app_repos.dart';
import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:list_transactions_fragment/list_transactions.dart';
import 'package:settings_fragment/settings_fragment.dart';
import 'package:small_screen/small_screen.dart';
import 'package:small_screen/small_screen_app_repos.dart';
import 'package:subscription_repository/subscription_repository.dart';

class BlitzApp extends StatefulWidget {
  final AuthRepo authRepo;
  final SettingsBloc settingsBloc;

  const BlitzApp({
    required this.authRepo,
    required this.settingsBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<BlitzApp> createState() => _BlitzAppState();
}

class _BlitzAppState extends State<BlitzApp> {
  late BigScreenAppRepos? bsaRepos;
  late SmallScreenAppRepos? ssaRepos;

  bool _big = false;

  @override
  void initState() {
    final subRepo = SubscriptionRepository(
      widget.authRepo.baseUrl(),
      widget.authRepo.token(),
    );
    subRepo.init();

    final btcInfoBloc = BitcoinInfoBloc(subRepo);
    btcInfoBloc.add(StartListenBitcoinInfo());

    final hardwareBloc = HardwareInfoBloc(subRepo, widget.authRepo);
    hardwareBloc.add(StartListenHardwareInfo());

    final listTxBloc = ListTxBloc(widget.authRepo, subRepo);
    listTxBloc.add(LoadMoreTx());

    final lnInfoBloc = LightningInfoBloc(widget.authRepo, subRepo);
    lnInfoBloc.add(StartListenLightningInfo());

    final systemBloc = SystemInfoBloc(subRepo);
    systemBloc.add(StartListenSystemInfo());

    final walletLockedChecker = WalletLockedCheckerBloc(subRepo);
    walletLockedChecker.add(StartCheckWalletLocked());

    _big = MediaQueryData.fromWindow(
          WidgetsBinding.instance.window,
        ).size.width >
        1024;

    if (_big) {
      bsaRepos = BigScreenAppRepos(
        authRepo: widget.authRepo,
        btcInfoBloc: btcInfoBloc,
        hardwareBloc: hardwareBloc,
        listTxBloc: listTxBloc,
        lnInfoBloc: lnInfoBloc,
        settingsBloc: widget.settingsBloc,
        subRepo: subRepo,
        systemBloc: systemBloc,
        walletLockedChecker: walletLockedChecker,
      );
    } else {
      ssaRepos = SmallScreenAppRepos(
        authRepo: widget.authRepo,
        btcInfoBloc: btcInfoBloc,
        hardwareBloc: hardwareBloc,
        listTxBloc: listTxBloc,
        lnInfoBloc: lnInfoBloc,
        settingsBloc: widget.settingsBloc,
        subRepo: subRepo,
        systemBloc: systemBloc,
        walletLockedChecker: walletLockedChecker,
      );
    }
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    bsaRepos?.dispose();
    ssaRepos?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GoRouter _router;

    if (_big) {
      _router = BigScreenApp.buildRouter(bsaRepos!);
    } else {
      _router = SmallScreenApp.buildRouter(ssaRepos!);
    }

    var localizationDelegate = LocalizedApp.of(context).delegate;
    return RepositoryProvider.value(
      value: widget.authRepo,
      child: BlocBuilder<SettingsBloc, SettingsBaseState>(
        bloc: widget.settingsBloc,
        builder: (context, state) {
          return MaterialApp.router(
            routeInformationProvider: _router.routeInformationProvider,
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
            title: tr('app.title'),
            theme: state.darkTheme ? ThemeData.dark() : ThemeData.light(),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              localizationDelegate
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            locale: localizationDelegate.currentLocale,
          );
        },
      ),
    );
  }
}
