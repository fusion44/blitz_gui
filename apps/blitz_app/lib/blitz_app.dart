import 'package:flutter/material.dart';

import 'package:authentication/authentication.dart';
import 'package:big_screen/big_screen.dart';
import 'package:common_widgets/common_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_fragment/settings_fragment.dart';
import 'package:small_screen/small_screen.dart';
import 'package:subscription_repository/subscription_repository.dart';

class BlitzApp extends StatefulWidget {
  const BlitzApp({Key? key}) : super(key: key);

  @override
  State<BlitzApp> createState() => _BlitzAppState();
}

class _BlitzAppState extends State<BlitzApp> {
  bool _initialized = false;
  bool _big = false;
  late final GoRouter _router;
  late final SubscriptionRepository _subRepo;
  bool _goLogin = false;
  final _sBloc = SettingsBloc();

  @override
  void initState() {
    super.initState();
    final authRepo = AuthRepo.instanceChecked();
    if (!authRepo.isLoggedIn) {
      _router = _buildLoginRouter();
      _goLogin = true;
      _initialized = true;
      return;
    }

    _initSubRepo();

    _big = MediaQueryData.fromWindow(
          WidgetsBinding.instance.window,
        ).size.width >
        1024;

    if (_big) {
      _router = BigScreenApp.buildRouter();
    } else {
      _router = SmallScreenApp.buildRouter();
    }
  }

  @override
  void dispose() async {
    super.dispose();
    SubscriptionRepository.instance().dispose();
    await SettingsRepository.instance().dispose();
    await _sBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: AuthBloc(),
      builder: (context, AuthState state) {
        if (state.status == AuthStatus.authenticated) {
          return _wrap(_buildLoggedInState(context));
        }

        if (state.status == AuthStatus.unauthenticated) {
          return _wrap(_buildLoggedOutState());
        }

        return MaterialApp(
          home: Scaffold(
            body: Center(child: Text("Unknown auth state: ${state.status}")),
          ),
        );
      },
    );
  }

  Widget _buildLoggedInState(BuildContext context) {
    if (!_initialized) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: Text("Loading ..."))),
      );
    }

    var localizationDelegate = LocalizedApp.of(context).delegate;
    return BlocBuilder<SettingsBloc, SettingsBaseState>(
      bloc: _sBloc,
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
    );
  }

  Widget _wrap(Widget child) {
    if (_goLogin) {
      // We don't need to wrap the login page
      return child;
    }

    return NotificationListener(
      onNotification: (SizeChangedLayoutNotification notification) {
        final big = MediaQueryData.fromWindow(
              WidgetsBinding.instance.window,
            ).size.width >
            1024;

        if (big != _big) RestartWidget.restartApp(context);

        return true;
      },
      child: SizeChangedLayoutNotifier(child: child),
    );
  }

  Widget _buildLoggedOutState() {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return BlocBuilder<SettingsBloc, SettingsBaseState>(
      bloc: _sBloc,
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
    );
  }

  void _initSubRepo() async {
    _subRepo = SubscriptionRepository.instance();
    final authRepo = AuthRepo.instanceChecked();
    await _subRepo.init(
      authRepo.baseUrl(),
      authRepo.token(),
    );
    setState(() => _initialized = true);
  }

  GoRouter _buildLoginRouter() {
    return GoRouter(
      initialLocation: LoginPage.path,
      routes: [
        GoRoute(
          name: LoginPage.routeName,
          path: LoginPage.path,
          builder: (context, state) {
            return LoginPage(() => RestartWidget.restartApp(context));
          },
        ),
      ],
      errorBuilder: (context, state) =>
          Scaffold(body: Center(child: Text(state.error.toString()))),
    );
  }
}
