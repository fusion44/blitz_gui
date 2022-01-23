import 'package:flutter/material.dart';

import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_fragment/settings_fragment.dart';

import 'widgets/header_bar.dart';

class BigScreenApp extends StatelessWidget {
  static String initialLocation = '/';

  static GoRouter buildRouter(AuthRepo authRepo) {
    final authBloc = AuthBloc(authRepository: authRepo);
    return GoRouter(
      redirect: (state) {
        var isLoggedIn = authRepo.isLoggedIn;
        var isLogging = state.location == LoginPage.path;

        if (!isLoggedIn && !isLogging) return LoginPage.path;
        if (isLoggedIn && isLogging) return initialLocation;
        return null;
      },
      urlPathStrategy: UrlPathStrategy.path,
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          name: LoginPage.routeName,
          path: LoginPage.path,
          builder: (context, state) {
            return BlocProvider.value(
              value: authBloc,
              child: LoginPage(
                () => context.goNamed(initialLocation),
              ),
            );
          },
        ),
        GoRoute(
          path: '/',
          name: Pages.dashboard.name,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: BlocProvider(
                create: (context) => AuthBloc(authRepository: authRepo),
                child: BigScreenApp(Pages.dashboard, key: state.pageKey),
              ),
            );
          },
        ),
        GoRoute(
          path: '/transactions',
          name: Pages.transactions.name,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: BlocProvider(
                create: (context) => AuthBloc(authRepository: authRepo),
                child: BigScreenApp(Pages.transactions, key: state.pageKey),
              ),
            );
          },
        ),
        GoRoute(
          path: '/channels',
          name: Pages.channels.name,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: BlocProvider(
                create: (context) => AuthBloc(authRepository: authRepo),
                child: BigScreenApp(Pages.channels, key: state.pageKey),
              ),
            );
          },
        ),
        GoRoute(
          path: '/apps',
          name: Pages.apps.name,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: BlocProvider(
                create: (context) => AuthBloc(authRepository: authRepo),
                child: BigScreenApp(Pages.apps, key: state.pageKey),
              ),
            );
          },
        ),
        GoRoute(
          path: '/settings',
          name: Pages.settings.name,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => AuthBloc(authRepository: authRepo),
              child: Scaffold(
                  appBar: AppBar(title: Text(tr('settings.settings'))),
                  body: SettingsView(key: state.pageKey)),
            );
          },
        )
      ],
      errorBuilder: (context, state) =>
          Scaffold(body: Center(child: Text(state.error.toString()))),
    );
  }

  final Pages currentPage;

  const BigScreenApp(this.currentPage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HeaderBar((item) {
              if (item == Pages.dashboard) {
                context.goNamed(Pages.dashboard.name);
              } else if (item == Pages.transactions) {
                context.goNamed(Pages.transactions.name);
              } else if (item == Pages.channels) {
                context.goNamed(Pages.channels.name);
              } else if (item == Pages.apps) {
                context.goNamed(Pages.apps.name);
              } else if (item == Pages.settings) {
                context.pushNamed(Pages.settings.name);
              } else if (item == Pages.reboot) {
                debugPrint('TODO: implement reboot system');
              } else if (item == Pages.shutdown) {
                debugPrint('TODO: implement shutdown system');
              } else if (item == Pages.logout) {
                debugPrint('TODO: implement logout');
              } else {
                debugPrint('Not implemented: $item');
              }
            }, currentPage),
          ),
          Center(child: Text(currentPage.name)),
        ],
      ),
    );
  }
}
