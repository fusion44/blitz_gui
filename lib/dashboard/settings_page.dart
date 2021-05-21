import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/settings_bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 32.0),
          BlocBuilder<SettingsBloc, SettingsState>(
            bloc: BlocProvider.of(context),
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Theme ', style: Theme.of(context).textTheme.headline5),
                  Icon(Icons.wb_sunny, color: Colors.yellow[600]),
                  Switch(
                      value: state.isDarkTheme,
                      onChanged: (value) {
                        var bloc = BlocProvider.of<SettingsBloc>(context);
                        bloc.add(ToggleThemeEvent());
                      }),
                  Icon(Icons.wb_twighlight, color: Colors.blueGrey),
                ],
              );
            },
          ),
          Divider(),
          Container(
            height: 50.0,
            width: 100.0,
            child: ElevatedButton(
              onPressed: () {
                final snackBar = SnackBar(content: Text('TODO :('));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              style: ElevatedButton.styleFrom(primary: Colors.orange),
              child: Text('REBOOT'),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            height: 50.0,
            width: 100.0,
            child: ElevatedButton(
              onPressed: () {
                final snackBar = SnackBar(content: Text('TODO :('));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Text('Shutdown'),
            ),
          ),
        ],
      ),
    );
  }
}
