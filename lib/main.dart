import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/settings_bloc/settings_bloc.dart';
import 'dashboard/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = SettingsBloc();
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (prev, curr) {
          if (prev is SettingsState &&
              curr is SettingsState &&
              prev.isDarkTheme != curr.isDarkTheme) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: state.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
            home: BlitzDashboard(),
          );
        },
      ),
    );
  }
}
