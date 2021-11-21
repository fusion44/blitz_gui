import 'dart:async';

import '../common/blocs/auth/auth_repository.dart';
import '../common/blocs/auth/login/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../common/blocs/auth/auth_bloc.dart';
import '../common/subscription_repository.dart';
import '../common/utils.dart';
import '../common/widgets/translated_text.dart';
import 'blocs/settings_bloc/settings_bloc.dart';
import 'funds_page.dart';
import 'info_page.dart';
import 'receive_page.dart';
import 'settings_page.dart';

class BlitzDashboard extends StatefulWidget {
  const BlitzDashboard({Key? key}) : super(key: key);

  @override
  _BlitzDashboardState createState() => _BlitzDashboardState();
}

class _BlitzDashboardState extends State<BlitzDashboard> {
  int state = 0;

  StreamSubscription<SettingsBaseState>? _settingsSub;

  bool _fabVisible = false;

  SubscriptionRepository? _subRepo;

  late StreamSubscription<AuthStatus> _authSub;

  late AuthRepo _authRepo;

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

    _authRepo = RepositoryProvider.of<AuthRepo>(context);

    super.initState();
  }

  @override
  void dispose() {
    _authSub.cancel();
    _settingsSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          _subRepo = SubscriptionRepository(_authRepo);
        } else {
          _subRepo = null;
        }
        setState(() {});
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            return const LoginPage();
          } else if (state.status == AuthStatus.authenticated) {
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
          } else {
            return Center(
              child: Text(
                'Unknown AuthState ${state.status.toString()}',
              ),
            );
          }
        },
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
        return const InfoPage();
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
