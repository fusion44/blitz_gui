import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:settings_fragment/settings_fragment.dart';

import 'base_app.dart';

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

  runApp(
    LocalizedApp(
      delegate,
      BaseApp(settingsBloc: bloc, authRepo: authRepo),
    ),
  );
}
