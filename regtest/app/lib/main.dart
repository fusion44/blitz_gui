import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:regtest_core/core.dart';

import 'gui_constants.dart';
import 'pages/main/main_page.dart';
import 'pages/sse_inspector/sse_inspector_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final InitializationSettings initializationSettings = InitializationSettings(
    linux: LinuxInitializationSettings(
      defaultActionName: 'Open notification',
      defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
    ),
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      logMessage('notification payload: $payload');
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // GoRouter configuration
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.home.name,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 300),
          key: state.pageKey,
          child: const MyHomePage(title: 'Regtest UI'),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(
                curve: Curves.easeInOutCirc,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/sse-tester',
        name: RouteNames.sseTester.name,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 300),
          key: state.pageKey,
          child: const SSEInspectorPage('http://192.168.1.49/api', 'test1234'),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(
                curve: Curves.easeInOutCirc,
              ).animate(animation),
              child: child,
            );
          },
        ),
      )
    ],
  );

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Regtest UI',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
