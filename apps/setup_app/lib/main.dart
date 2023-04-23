import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';

import 'initial_screen.dart';
import 'new_node/bloc/setup_bloc.dart';
import 'new_node/chose_sd_card_state.dart';
import 'new_node/prepare_sd_card/10_chose_release_page.dart';
import 'new_node/prepare_sd_card/20_download_release_image.dart';
import 'new_node/prepare_sd_card/30_flash_card_page.dart';
import 'new_node/prepare_sd_card/models/file_data.dart';
import 'new_node/setup/10_device_details.dart';
import 'new_node/setup/20_connect.dart';
import 'new_node/setup/30_password_input.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en'],
  );

  runApp(
    LocalizedApp(delegate, MyApp(NewNodeSetupBloc())),
  );
}

class MyApp extends StatelessWidget {
  late final GoRouter _router;
  final NewNodeSetupBloc _setupBloc;

  MyApp(this._setupBloc, {Key? key}) : super(key: key) {
    _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const InitialScreen(),
        ),
        GoRoute(
          path: '/find-device',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: FindDeviceDetailsPage(),
          ),
        ),
        GoRoute(
          path: '/connect-device',
          pageBuilder: (context, state) {
            final url = state.extra;
            if (url == null || url is! String) {
              throw ArgumentError(
                'state.extra must be a non-null String, but was ${state.extra.runtimeType}',
              );
            }

            _setupBloc.add(ConnectNodeEvent(url));
            return NoTransitionPage(
              child: BlocProvider.value(
                value: _setupBloc,
                child: ConnectPage(url),
              ),
            );
          },
        ),
        GoRoute(
          path: '/get-passwords',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PasswordInputPage(),
          ),
        ),
        GoRoute(
          path: '/new-node',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ChoseSDCardStateScreen(),
          ),
          routes: [
            GoRoute(
              path: 'chose-release',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ChoseReleasePage(),
              ),
            ),
            GoRoute(
              path: 'download-release-image',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: DownloadReleasePage(),
              ),
            ),
            GoRoute(
              path: 'actually-flash-card',
              pageBuilder: (context, state) {
                final e = state.extra;
                if (e == null || e is! List<FileData>) {
                  throw ArgumentError(
                    'No List<FileData> was passed as argument',
                  );
                }

                return NoTransitionPage(
                  child: FlashCardPage(files: e),
                );
              },
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => Text('Error: ${state.error}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark(),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}
