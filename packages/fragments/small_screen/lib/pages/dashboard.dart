// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:info_screen_plus_plus/info_screen_plus_plus.dart';
import 'package:list_transactions_fragment/list_transactions.dart';
import 'package:settings_fragment/settings_fragment.dart';
import 'package:subscription_repository/subscription_repository.dart';

class BlitzDashboardAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Widget? leading;
  final double? elevation;
  final String? flexiText;

  const BlitzDashboardAppBar({
    required this.title,
    required this.backgroundColor,
    this.leading,
    this.elevation,
    this.flexiText,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppBar(
      primary: true,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      titleSpacing: 10,
      title: Text(title),
      centerTitle: false,
      elevation: elevation,
      leadingWidth: 35,
      leading: leading,
      flexibleSpace: flexiText != null
          ? Center(child: Text(flexiText!, style: theme.textTheme.headline6))
          : null,
    );
  }
}

class TabPageData {
  final String id;
  final String label;
  final IconData icon;

  TabPageData(this.id, this.label, this.icon);
}

class BlitzDashboard extends StatefulWidget {
  static String path = '/dashboard';
  static String subPath = '/dashboard/:page_id';
  static String routeName = 'dashboard';
  static String defaultPageId = pages.first.id;
  static Map<String, String> defaultPageParam = {
    'page_id': BlitzDashboard.defaultPageId,
  };

  static final pages = [
    TabPageData(
      'system',
      'System',
      Icons.info_outline_rounded,
    ),
    TabPageData(
      'connect',
      'Connect',
      Icons.insert_link_rounded,
    ),
    TabPageData(
      'transactions',
      'Transactions',
      Icons.account_balance_wallet,
    ),
    TabPageData(
      'settings',
      'Settings',
      Icons.settings,
    ),
  ];

  final TabPageData currentTabData;

  const BlitzDashboard(this.currentTabData, {Key? key}) : super(key: key);

  @override
  _BlitzDashboardState createState() => _BlitzDashboardState();
}

class _BlitzDashboardState extends State<BlitzDashboard> {
  StreamSubscription<SettingsBaseState>? _settingsSub;

  late final WalletLockedCheckerBloc _walletLockedChecker;
  late final SubscriptionRepository _subRepo;
  late final SystemInfoBloc _systemBloc;
  late final HardwareInfoBloc _hardwareBloc;
  late final BitcoinInfoBloc _btcInfoBloc;
  late final LightningInfoBloc _lnInfoBloc;
  late final ListTxBloc _listTxBloc;

  int _selectedIndex = 0;
  bool _ready = false;
  @override
  void initState() {
    changeLocale(context, 'en');
    updateTimeAgoLib('en');

    final bloc = BlocProvider.of<SettingsBloc>(context);
    _settingsSub = bloc.stream.listen((state) {
      changeLocale(context, state.langCode);
      updateTimeAgoLib(state.langCode);
      setState(() {});
    });

    _initBlocs();

    super.initState();
  }

  @override
  void dispose() async {
    await _settingsSub?.cancel();
    _hardwareBloc.add(StopListenHardwareInfo());
    _systemBloc.add(StopListenSystemInfo());
    _btcInfoBloc.add(StopListenBitcoinInfo());
    _lnInfoBloc.add(StopListenLightningInfo());
    await _listTxBloc.dispose();
    super.dispose();
  }

  void _initBlocs() async {
    final authRepo = RepositoryProvider.of<AuthRepo>(context);
    _subRepo = SubscriptionRepository(
      authRepo.baseUrl(),
      authRepo.token(),
    );
    await _subRepo.init();

    _walletLockedChecker = WalletLockedCheckerBloc(_subRepo);
    _hardwareBloc = HardwareInfoBloc(_subRepo, authRepo);
    _systemBloc = SystemInfoBloc(_subRepo);
    _btcInfoBloc = BitcoinInfoBloc(_subRepo);
    _lnInfoBloc = LightningInfoBloc(authRepo, _subRepo);
    _listTxBloc = ListTxBloc(authRepo, _subRepo);

    _walletLockedChecker.add(StartCheckWalletLocked());
    _hardwareBloc.add(StartListenHardwareInfo());
    _systemBloc.add(StartListenSystemInfo());
    _btcInfoBloc.add(StartListenBitcoinInfo());
    _lnInfoBloc.add(StartListenLightningInfo());
    _listTxBloc.add(LoadMoreTx());

    setState(() {
      _ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: BlitzDashboardAppBar(
        title: 'Raspiblitz',
        backgroundColor: Colors.green,
        elevation: 3,
        flexiText: widget.currentTabData.label,
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset('assets/RaspiBlitz_Logo_Icon_Negative.png'),
        ),
      ),
      body: _ready
          ? Row(
              children: [
                _buildNavRail(context, theme),
                Expanded(child: _buildBody(theme)),
              ],
            )
          : const Center(child: Text('Loading ...')),
    );
  }

  NavigationRail _buildNavRail(BuildContext context, ThemeData theme) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      elevation: 5,
      onDestinationSelected: (i) {
        if (i == _selectedIndex) return;
        context.goNamed(
          BlitzDashboard.routeName,
          params: {'page_id': BlitzDashboard.pages[i].id},
        );
        setState(() {
          _selectedIndex = i;
        });
      },
      destinations: [
        for (final p in BlitzDashboard.pages)
          NavigationRailDestination(
            icon: Icon(p.icon, size: 55),
            label: Text(p.label),
            padding: const EdgeInsets.all(8),
          ),
      ],
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (widget.currentTabData.id == BlitzDashboard.pages.first.id) {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _walletLockedChecker),
          BlocProvider.value(value: _systemBloc),
          BlocProvider.value(value: _btcInfoBloc),
          BlocProvider.value(value: _hardwareBloc),
          BlocProvider.value(value: _lnInfoBloc),
        ],
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: InfoScreenPlusPlus(),
        ),
      );
    } else if (widget.currentTabData.id == BlitzDashboard.pages[2].id) {
      return BlocProvider.value(
        value: _listTxBloc,
        child: Expanded(
          child: Column(
            children: [
              Text(
                'Overview Widget goes here',
                style: theme.textTheme.headline3,
              ),
              Expanded(
                child: FundsPage((visible) => debugPrint(visible.toString())),
              ),
            ],
          ),
        ),
      );
    } else if (widget.currentTabData.id == BlitzDashboard.pages[3].id) {
      return const Expanded(child: SettingsView());
    } else {
      return Center(child: Text(widget.currentTabData.label));
    }
  }
}
