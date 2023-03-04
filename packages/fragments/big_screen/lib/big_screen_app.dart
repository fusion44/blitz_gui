import 'package:flutter/material.dart';

import 'package:authentication/authentication.dart';
import 'package:big_screen/widgets/widgets.dart';
import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:list_transactions_fragment/list_transactions.dart';
import 'package:settings_fragment/settings_fragment.dart';

class BigScreenApp extends StatefulWidget {
  static String initialLocation = '/';

  static _provide(
    Pages page,
    AuthRepo authRepo, {
    required Widget child,
  }) {
    final blocs = [
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(authRepository: authRepo),
      ),
      if (page == Pages.transactions || page == Pages.dashboard)
        BlocProvider<LightningInfoBloc>(
          create: (context) => LightningInfoBloc(authRepo),
        ),
      if (page == Pages.transactions)
        BlocProvider<ListTxBloc>(
          create: (context) => ListTxBloc(authRepo)..add(LoadMoreTx()),
        ),
    ];

    final repos = [
      if (page == Pages.dashboard)
        RepositoryProvider(
          create: (context) => FeeRevenueRepository(authRepo),
        )
    ];

    return MultiBlocProvider(
      providers: blocs,
      child: repos.isEmpty
          ? child
          : MultiRepositoryProvider(
              providers: repos,
              child: child,
            ),
    );
  }

  static GoRouter buildRouter(AuthRepo authRepo) {
    final authBloc = AuthBloc(authRepository: authRepo);

    return GoRouter(
      redirect: (context, state) {
        var isLoggedIn = authRepo.isLoggedIn;
        var isLogging = state.location == LoginPage.path;

        if (!isLoggedIn && !isLogging) return LoginPage.path;
        if (isLoggedIn && isLogging) return initialLocation;
        return null;
      },
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
              child: BigScreenApp._provide(
                Pages.dashboard,
                authRepo,
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
              child: BigScreenApp._provide(
                Pages.transactions,
                authRepo,
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
              child: BigScreenApp._provide(
                Pages.apps,
                authRepo,
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
  State<BigScreenApp> createState() => _BigScreenAppState();
}

class _BigScreenAppState extends State<BigScreenApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildHeaderBar(context),
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    switch (widget.currentPage) {
      case Pages.dashboard:
        return const BigScreenDashboard();
      case Pages.transactions:
        return const BigScreenTxWidget();
      default:
        return Center(child: Text(widget.currentPage.name));
    }
  }

  Padding _buildHeaderBar(BuildContext context) {
    return Padding(
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
      }, widget.currentPage),
    );
  }
}
