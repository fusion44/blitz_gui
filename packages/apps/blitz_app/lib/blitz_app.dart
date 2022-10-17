import 'package:flutter/material.dart';

import 'package:authentication/authentication.dart';
import 'package:big_screen/big_screen.dart';
import 'package:common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_fragment/settings_fragment.dart';
import 'package:small_screen/small_screen.dart';
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
  bool _initialized = false;
  bool _big = false;
  late final GoRouter _router;
  late final SubscriptionRepository _subRepo;

  @override
  void initState() {
    _initSubRepo();

    _big = MediaQueryData.fromWindow(
          WidgetsBinding.instance.window,
        ).size.width >
        1024;

    if (_big) {
      _router = BigScreenApp.buildRouter(widget.authRepo, _subRepo);
    } else {
      _router = SmallScreenApp.buildRouter(widget.authRepo);
    }

    super.initState();
  }

  @override
  void dispose() {
    _subRepo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: Text("Loading ..."))),
      );
    }

    var localizationDelegate = LocalizedApp.of(context).delegate;
    return RepositoryProvider.value(
      value: widget.authRepo,
      child: BlocBuilder<SettingsBloc, SettingsBaseState>(
        bloc: widget.settingsBloc,
        builder: (context, state) {
          return _wrap(
            MaterialApp.router(
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
            ),
          );
        },
      ),
    );
  }

  Widget _wrap(Widget child) {
    return NotificationListener(
      onNotification: (SizeChangedLayoutNotification notification) {
        final big = MediaQueryData.fromWindow(
              WidgetsBinding.instance.window,
            ).size.width >
            1024;

        if (big != _big) RestartWidget.restartApp(context);

        return true;
      },
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: widget.authRepo),
          RepositoryProvider.value(value: _subRepo),
        ],
        child: BlocProvider.value(
          value: widget.settingsBloc,
          child: SizeChangedLayoutNotifier(child: child),
        ),
      ),
    );
  }

  void _initSubRepo() async {
    _subRepo = SubscriptionRepository(
      widget.authRepo.baseUrl(),
      widget.authRepo.token(),
    );
    await _subRepo.init();
    setState(() => _initialized = true);
  }
}
