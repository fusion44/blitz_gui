import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:subscription_repository/subscription_repository.dart';

import 'settings/pages/settings_page.dart';
import 'settings/settings_bloc/settings_bloc.dart';
import 'system/bitcoin_info/bitcoin_info_bloc.dart';
import 'system/hardware_info/hardware_info_bloc.dart';
import 'system/info_page.dart';
import 'system/system_info/system_info_bloc.dart';
import 'wallet/lightning_info/bloc/lightning_info_bloc.dart';
import 'wallet/pages/funds_page.dart';
import 'wallet/pages/receive_page.dart';

class BlitzDashboard extends StatefulWidget {
  static String path = '/';
  static String routeName = 'dashboard';

  const BlitzDashboard({Key? key}) : super(key: key);

  @override
  _BlitzDashboardState createState() => _BlitzDashboardState();
}

class _BlitzDashboardState extends State<BlitzDashboard> {
  int state = 0;

  StreamSubscription<SettingsBaseState>? _settingsSub;

  bool _fabVisible = false;

  late final SubscriptionRepository _subRepo;
  late final SystemInfoBloc _systemBloc;
  late final HardwareInfoBloc _hardwareBloc;
  late final BitcoinInfoBloc _btcInfoBloc;
  late final LightningInfoBloc _lnInfoBloc;

  @override
  void initState() {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (authBloc.state.status != AuthStatus.authenticated) {
      GoRouter.of(context).goNamed(LoginPage.routeName);
    }

    changeLocale(context, 'en');
    updateTimeAgoLib('en');

    final bloc = BlocProvider.of<SettingsBloc>(context);
    _settingsSub = bloc.stream.listen((state) {
      changeLocale(context, state.langCode);
      updateTimeAgoLib(state.langCode);
      setState(() {});
    });

    final _authRepo = RepositoryProvider.of<AuthRepo>(context);
    _subRepo = SubscriptionRepository(
      _authRepo.baseUrl(),
      _authRepo.token(),
    );

    _hardwareBloc = HardwareInfoBloc(_subRepo, _authRepo);
    _systemBloc = SystemInfoBloc(_subRepo);
    _btcInfoBloc = BitcoinInfoBloc(_subRepo);
    _lnInfoBloc = LightningInfoBloc(_subRepo);

    _hardwareBloc.add(StartListenHardwareInfo());
    _systemBloc.add(StartListenSystemInfo());
    _btcInfoBloc.add(StartListenBitcoinInfo());
    _lnInfoBloc.add(StartListenLightningInfo());
    super.initState();
  }

  @override
  void dispose() {
    _settingsSub?.cancel();
    _hardwareBloc.add(StopListenHardwareInfo());
    _systemBloc.add(StopListenSystemInfo());
    _btcInfoBloc.add(StopListenBitcoinInfo());
    _lnInfoBloc.add(StopListenLightningInfo());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: _buildFAB(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeaderBar(theme),
          _buildBottom(theme),
        ],
      ),
    );
  }

  Widget _buildBottom(ThemeData theme) {
    return Expanded(
      child: Row(
        children: [
          _buildSideBar(),
          Expanded(
            child: RepositoryProvider.value(
              value: _subRepo,
              child: _buildBody(theme.textTheme.headline4!),
            ),
          )
        ],
      ),
    );
  }

  Material _buildSideBar() {
    return Material(
      elevation: 4.0,
      child: SizedBox(
        width: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    state = 0;
                    _fabVisible = false;
                  });
                },
                child: const TrText(
                  'dashboard.info_button',
                  overflow: TextOverflow.ellipsis,
                  isButton: true,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    state = 1;
                    _fabVisible = false;
                  });
                },
                child: const TrText(
                  'dashboard.node_button',
                  overflow: TextOverflow.ellipsis,
                  isButton: true,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    state = 2;
                    _fabVisible = true;
                  });
                },
                child: const TrText(
                  'dashboard.funds_button',
                  overflow: TextOverflow.ellipsis,
                  isButton: true,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    state = 3;
                    _fabVisible = false;
                  });
                },
                child: const TrText(
                  'dashboard.settings_button',
                  overflow: TextOverflow.ellipsis,
                  isButton: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material _buildHeaderBar(ThemeData theme) {
    return Material(
      elevation: 3.0,
      child: Container(
        color: Colors.transparent,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 16.0),
            SizedBox(
              height: 20,
              child: Image.asset('assets/RaspiBlitz_Logo_Icon_Negative.png'),
            ),
            const SizedBox(width: 8),
            Text(
              'Raspiblitz V1.7',
              style: theme.textTheme.headline5!,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(TextStyle style) {
    switch (state) {
      case 0:
        return InfoPage(
          btcInfoBloc: _btcInfoBloc,
          lnInfoBloc: _lnInfoBloc,
          hardwareBloc: _hardwareBloc,
          systemBloc: _systemBloc,
        );
      case 1:
        return QrImage(
          backgroundColor: Colors.grey[300]!,
          data: '1234567890',
          version: QrVersions.auto,
          size: 180.0,
        );
      case 2:
        return FundsPage(_setFABVisible);
      case 3:
        return const SettingsPage();
      default:
        return const Text('Other State');
    }
  }

  void _setFABVisible(bool visible) {
    setState(() {
      _fabVisible = visible;
    });
  }

  Visibility _buildFAB(BuildContext context) {
    return Visibility(
      visible: _fabVisible,
      child: FloatingActionButton(
        mini: true,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => RepositoryProvider.value(
                value: _subRepo,
                child: const ReceivePage(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
