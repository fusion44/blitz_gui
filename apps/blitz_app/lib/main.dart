import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:common_widgets/common_widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:settings_fragment/settings_fragment.dart';

import 'blitz_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    usePathUrlStrategy();
    var appDir = await getApplicationSupportDirectory();
    Hive.init(appDir.path);
  }

  BlitzLog.level = LogLevel.warning;

  await SettingsRepository.instance().init();

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en'],
  );

  final authRepo = AuthRepo.instance();
  await authRepo.init();

  runApp(
    LocalizedApp(
      delegate,
      const RestartWidget(
        child: BlitzApp(),
      ),
    ),
  );
}
