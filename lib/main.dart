import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'dashboard/dashboard.dart';
import 'dashboard/settings/settings_bloc/settings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    var appDir = await getApplicationSupportDirectory();
    Hive.init(appDir.path);
  }

  BlitzLog.level = LogLevel.warning;

  final bloc = SettingsBloc();
  bloc.add(AppStartEvent());

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en'],
  );

  final authRepo = AuthRepo();
  await authRepo.init();

  runApp(LocalizedApp(delegate, MyApp(bloc, authRepo)));
}

class MyApp extends StatefulWidget {
  final SettingsBloc bloc;
  final AuthRepo authRepo;

  const MyApp(this.bloc, this.authRepo, {Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;
  late final AuthBloc _authBloc;
  late StreamSubscription<AuthState> _authSub;

  @override
  void initState() {
    _authBloc = AuthBloc(authRepository: widget.authRepo);

    _router = GoRouter(
      redirect: (state) {
        var isLoggedIn = widget.authRepo.isLoggedIn;
        var isLogging = state.location == LoginPage.path;

        if (!isLoggedIn && !isLogging) return LoginPage.path;
        if (isLoggedIn && isLogging) return BlitzDashboard.path;
        return null;
      },
      urlPathStrategy: UrlPathStrategy.path,
      initialLocation: '/',
      routes: [
        GoRoute(
          name: BlitzDashboard.routeName,
          path: BlitzDashboard.path,
          pageBuilder: _buildHomePage,
        ),
        GoRoute(
          name: LoginPage.routeName,
          path: LoginPage.path,
          pageBuilder: _buildLoginPage,
        ),
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: Scaffold(body: Center(child: Text(state.error.toString()))),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _authSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return RepositoryProvider.value(
      value: widget.authRepo,
      child: BlocProvider.value(
        value: widget.bloc,
        child: BlocBuilder<SettingsBloc, SettingsBaseState>(
          builder: (context, state) {
            return MaterialApp.router(
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
      ),
    );
  }

  Page<dynamic> _buildHomePage(context, state) {
    return MaterialPage(
      key: state.pageKey,
      child: BlocProvider.value(
        value: _authBloc,
        child: RepositoryProvider.value(
          value: widget.authRepo,
          child: const BlitzDashboard(),
        ),
      ),
    );
  }

  Page<dynamic> _buildLoginPage(context, state) {
    return MaterialPage(
      key: state.pageKey,
      child: BlocProvider.value(
        value: _authBloc,
        child: LoginPage(
          () => _router.goNamed(BlitzDashboard.routeName),
        ),
      ),
    );
  }
}
