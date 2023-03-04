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
          ? Center(child: Text(flexiText!, style: theme.textTheme.titleLarge))
          : null,
    );
  }
}

class SmallScreenApp extends StatefulWidget {
  static const String _routeName = 'dashboard';
  static final String _initialLocation = '/dashboard/${_pages.first.id}';

  static GoRouter buildRouter(AuthRepo authRepo) {
    return GoRouter(
      redirect: (context, state) {
        var isLoggedIn = authRepo.isLoggedIn;
        var isLogging = state.location == LoginPage.path;

        if (!isLoggedIn && !isLogging) return LoginPage.path;
        if (isLoggedIn && isLogging) return _initialLocation;
        return null;
      },
      initialLocation: _initialLocation,
      routes: [
        GoRoute(
          name: LoginPage.routeName,
          path: LoginPage.path,
          builder: (context, state) {
            return BlocProvider(
              create: (c) => AuthBloc(authRepository: authRepo),
              child: LoginPage(
                () => context.goNamed(_initialLocation, params: {}),
              ),
            );
          },
        ),
        GoRoute(
          name: SmallScreenApp._routeName,
          path: '/dashboard/:page_id',
          builder: (context, state) {
            final pageId = state.params['page_id']!;
            final tabData = SmallScreenApp._pages.firstWhere(
              (f) => f.id == pageId,
              orElse: () => throw Exception('Page not found: $pageId'),
            );

            return BlocProvider(
                create: (c) => SettingsBloc(),
                child: SmallScreenApp(tabData, key: state.pageKey));
          },
        )
      ],
      errorBuilder: (context, state) =>
          Scaffold(body: Center(child: Text(state.error.toString()))),
    );
  }

  static final _pages = [
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

  const SmallScreenApp(this.currentTabData, {Key? key}) : super(key: key);

  @override
  _SmallScreenAppState createState() => _SmallScreenAppState();
}

class _SmallScreenAppState extends State<SmallScreenApp> {
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
    super.dispose();
    await _settingsSub?.cancel();
    _hardwareBloc.add(StopListenHardwareInfo());
    _systemBloc.add(StopListenSystemInfo());
    _btcInfoBloc.add(StopListenBitcoinInfo());
    _lnInfoBloc.add(StopListenLightningInfo());
    await _listTxBloc.dispose();
  }

  void _initBlocs() async {
    final authRepo = RepositoryProvider.of<AuthRepo>(context);
    _subRepo = SubscriptionRepository.instanceChecked();

    _walletLockedChecker = WalletLockedCheckerBloc(_subRepo);
    _hardwareBloc = HardwareInfoBloc(_subRepo, authRepo);
    _systemBloc = SystemInfoBloc(_subRepo);
    _btcInfoBloc = BitcoinInfoBloc(_subRepo);
    _lnInfoBloc = LightningInfoBloc(authRepo);
    _listTxBloc = ListTxBloc(authRepo);

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
          SmallScreenApp._routeName,
          params: {'page_id': SmallScreenApp._pages[i].id},
        );
        setState(() {
          _selectedIndex = i;
        });
      },
      destinations: [
        for (final p in SmallScreenApp._pages)
          NavigationRailDestination(
            icon: Icon(p.icon, size: 55),
            label: Text(p.label),
            padding: const EdgeInsets.all(8),
          ),
      ],
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (widget.currentTabData.id == SmallScreenApp._pages.first.id) {
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
    } else if (widget.currentTabData.id == SmallScreenApp._pages[2].id) {
      return BlocProvider.value(
        value: _listTxBloc,
        child: Expanded(
          child: Column(
            children: [
              Text(
                'Overview Widget goes here',
                style: theme.textTheme.displaySmall,
              ),
              Expanded(
                child: FundsPage((visible) => debugPrint(visible.toString())),
              ),
            ],
          ),
        ),
      );
    } else if (widget.currentTabData.id == SmallScreenApp._pages[3].id) {
      return Expanded(
        child: BlocProvider(
          create: (context) => SettingsBloc(),
          child: const SettingsView(),
        ),
      );
    } else {
      return Center(child: Text(widget.currentTabData.label));
    }
  }
}
