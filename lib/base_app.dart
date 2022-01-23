import 'package:authentication/authentication.dart';
import 'package:big_screen/big_screen.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:settings_fragment/settings_fragment.dart';
import 'package:small_screen/small_screen.dart';
import 'package:go_router/go_router.dart';

class BaseApp extends StatefulWidget {
  final AuthRepo authRepo;
  final SettingsBloc settingsBloc;

  const BaseApp({
    required this.authRepo,
    required this.settingsBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext context) {
    final big =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width >
            1024;

    final GoRouter _router;

    if (big) {
      _router = BigScreenApp.buildRouter(widget.authRepo);
    } else {
      _router = SmallScreenApp.buildRouter(widget.authRepo);
    }

    var localizationDelegate = LocalizedApp.of(context).delegate;
    return RepositoryProvider.value(
      value: widget.authRepo,
      child: BlocProvider.value(
        value: widget.settingsBloc,
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
}
