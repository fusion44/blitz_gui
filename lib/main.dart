import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'common/utils.dart';
import 'dashboard/blocs/settings_bloc/settings_bloc.dart';
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
  runApp(LocalizedApp(delegate, MyApp(bloc)));
}

class MyApp extends StatefulWidget {
  final SettingsBloc _bloc;

  const MyApp(this._bloc, {Key? key}) : super(key: key);

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
            home: _buildHome(context),
          );
        },
      ),
    );
  }

  Widget _buildHome(BuildContext context) {
    if (_setupType.isEmpty) {
      return SetupHome((type) {
        setState(() {
          _setupType = type;
        });
      });
    } else if (_setupType == SetupTypeSwitch.newNode) {
      return const NewNodeSetupPage();
    } else {
      return Scaffold(body: Center(child: Text('Unknown: $_setupType')));
    }
  }
}
