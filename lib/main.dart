import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/settings_bloc/settings_bloc.dart';
import 'common/utils.dart';
import 'dashboard/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    var appDir = await getApplicationSupportDirectory();
    if (appDir != null) {
      Hive.init(appDir.path);
    } else {
      NullThrownError();
    }
  }

  final bloc = SettingsBloc();
  bloc.add(AppStartEvent());
  final SettingsLoadedState res =
      await bloc.stream.firstWhere((s) => s is SettingsLoadedState);

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: res.langCode,
    supportedLocales: ['en', 'de'],
  );
  runApp(LocalizedApp(delegate, MyApp(bloc)));
}

class MyApp extends StatelessWidget {
  final SettingsBloc _bloc;

  MyApp(this._bloc);

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<SettingsBloc, SettingsBaseState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: tr('app.title'),
            theme: state.darkTheme ? ThemeData.dark() : ThemeData.light(),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              localizationDelegate
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            locale: localizationDelegate.currentLocale,
            home: BlitzDashboard(),
          );
        },
      ),
    );
  }
}
