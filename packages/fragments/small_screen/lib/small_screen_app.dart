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

import 'small_screen_app_repos.dart';

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

class SmallScreenApp extends StatefulWidget {
  static const String _routeName = 'dashboard';
  static final String _initialLocation = '/dashboard/${_pages.first.id}';

  static GoRouter buildRouter(SmallScreenAppRepos repos) {
    return GoRouter(
      redirect: (state) {
        var isLoggedIn = repos.authRepo.isLoggedIn;
        var isLogging = state.location == LoginPage.path;

        if (!isLoggedIn && !isLogging) return LoginPage.path;
        if (isLoggedIn && isLogging) return _initialLocation;
        return null;
      },
      urlPathStrategy: UrlPathStrategy.path,
      initialLocation: _initialLocation,
      routes: [
        GoRoute(
          name: LoginPage.routeName,
          path: LoginPage.path,
          builder: (context, state) {
            return BlocProvider(
              create: (c) => AuthBloc(authRepository: repos.authRepo),
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

            return repos.provide(
              child: SmallScreenApp(tabData, key: state.pageKey),
            );
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
    final _authRepo = RepositoryProvider.of<AuthRepo>(context);
    _subRepo = SubscriptionRepository(
      _authRepo.baseUrl(),
      _authRepo.token(),
    );
    await _subRepo.init();

    _walletLockedChecker = WalletLockedCheckerBloc(_subRepo);
    _hardwareBloc = HardwareInfoBloc(_subRepo, _authRepo);
    _systemBloc = SystemInfoBloc(_subRepo);
    _btcInfoBloc = BitcoinInfoBloc(_subRepo);
    _lnInfoBloc = LightningInfoBloc(_authRepo, _subRepo);
    _listTxBloc = ListTxBloc(_authRepo, _subRepo);

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
                style: theme.textTheme.headline3,
              ),
              Expanded(
                child: FundsPage((visible) => debugPrint(visible.toString())),
              ),
            ],
          ),
        ),
      );
    } else if (widget.currentTabData.id == SmallScreenApp._pages[3].id) {
      return const Expanded(child: SettingsView());
    } else {
      return Center(child: Text(widget.currentTabData.label));
    }
  }
}
