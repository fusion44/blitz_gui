import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_fragment/settings_fragment.dart';
import 'package:subscription_repository/subscription_repository.dart';

import 'system/bitcoin_info/bitcoin_info_bloc.dart';
import 'system/hardware_info/hardware_info_bloc.dart';
import 'system/system_info/system_info_bloc.dart';
import 'wallet/lightning_info/bloc/lightning_info_bloc.dart';
import 'wallet/wallet_locked_checker/wallet_locked_checker_bloc.dart';

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
  static String defaultPageId = pages[0].id;
  static Map<String, String> defaultPageParam = {
    'page_id': BlitzDashboard.defaultPageId
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

  int _selectedIndex = 0;

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

    _walletLockedChecker = WalletLockedCheckerBloc(_subRepo);
    _hardwareBloc = HardwareInfoBloc(_subRepo, _authRepo);
    _systemBloc = SystemInfoBloc(_subRepo);
    _btcInfoBloc = BitcoinInfoBloc(_subRepo);
    _lnInfoBloc = LightningInfoBloc(_subRepo);

    _walletLockedChecker.add(StartCheckWalletLocked());
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
      body: Row(
        children: [
          _buildNavRail(context, theme),
          _buildBody(theme),
        ],
      ),
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
          )
      ],
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (widget.currentTabData.id == BlitzDashboard.pages[3].id) {
      return const Expanded(child: SettingsView());
    } else {
      return Expanded(
        child: Center(child: Text(widget.currentTabData.label)),
      );
    }
  }
}
