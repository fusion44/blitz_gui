import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'dashboard/dashboard.dart';
import 'dashboard/settings/settings_bloc/settings_bloc.dart';
import 'setup/new_node/new_node_setup_page.dart';
import 'setup/setup_home.dart';
import 'setup/setup_type_switch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    var appDir = await getApplicationSupportDirectory();
    Hive.init(appDir.path);
  }

  final bloc = SettingsBloc();
  bloc.add(AppStartEvent());

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en'],
  );
  runApp(LocalizedApp(delegate, MyApp(bloc, AuthRepo())));
}

class MyApp extends StatefulWidget {
  final SettingsBloc _bloc;
  final AuthRepo _authRepo;

  const MyApp(this._bloc, this._authRepo, {Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _setupType = '';

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return BlocProvider.value(
      value: widget._bloc,
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
            home: _buildHome(context, 'dashboard'),
          );
        },
      ),
    );
  }

  Widget _buildHome(BuildContext context, String what) {
    Widget child;

    if (what == 'dashboard') {
      child = RepositoryProvider.value(
        value: widget._authRepo,
        child: const BlitzDashboard(),
      );
    } else {
      if (_setupType.isEmpty) {
        child = SetupHome((type) {
          setState(() {
            _setupType = type;
          });
        });
      } else if (_setupType == SetupTypeSwitch.newNode) {
        child = const NewNodeSetupPage();
      } else {
        child = Scaffold(body: Center(child: Text('Unknown: $_setupType')));
      }
    }

    return BlocProvider(
      create: (_) => AuthBloc(authRepository: widget._authRepo),
      child: child,
    );
  }
}
