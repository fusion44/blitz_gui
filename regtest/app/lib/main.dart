import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:regtest_app/blocs/network_bloc/network_bloc.dart';
import 'package:regtest_core/core.dart';

import 'gui_constants.dart';
import 'pages/containers/containers_page.dart';
import 'pages/main/main_page.dart';
import 'pages/sse_inspector/sse_inspector_page.dart';
import 'terminal_sub_window.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (args.firstOrNull == 'multi_window') {
    final argument = args[2].isEmpty
        ? const {}
        : jsonDecode(args[2]) as Map<String, dynamic>;
    final windowId = int.parse(args[1]);

    var title = argument['title'];
    var cmds = argument['autoCommands'];
    if (cmds is List<dynamic>) {
      cmds = cmds.map<String>((e) => e.toString()).toList();
    }

    runApp(TerminalSubWindow(
        cmds, title, WindowController.fromWindowId(windowId)));

    return;
  }

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

  runApp(MyApp(NetworkBloc()));
}

class MyApp extends StatelessWidget {
  final NetworkBloc networkBloc;

  const MyApp(this.networkBloc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // GoRouter configuration
    final _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: RouteNames.machineRoom.name,
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 300),
            key: state.pageKey,
            child: BlocProvider.value(
              value: networkBloc,
              child: const MyHomePage(title: 'Regtest UI'),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
          path: '/containers',
          name: RouteNames.containers.name,
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 300),
            key: state.pageKey,
            child: BlocProvider.value(
              value: networkBloc,
              child: const ContainersPage(title: 'Containers'),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
            child:
                const SSEInspectorPage('http://192.168.1.49/api', 'test1234'),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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

    return MaterialApp.router(
      title: 'Regtest UI',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
