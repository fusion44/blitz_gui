import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/settings_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 32.0),
          BlocBuilder<SettingsBloc, SettingsBaseState>(
            bloc: BlocProvider.of(context),
            builder: (context, state) {
              return ListTile(
                title: const TrText('settings.language_label'),
                trailing: DropdownButton(
                  value: state.langCode,
                  onChanged: (String? value) {
                    BlocProvider.of<SettingsBloc>(context).add(
                      ChangeLanguageEvent(value!),
                    );
                  },
                  items: _buildLanguageItems(),
                ),
              );
            },
          ),
          BlocBuilder<SettingsBloc, SettingsBaseState>(
            bloc: BlocProvider.of(context),
            builder: (context, state) {
              return ListTile(
                title: const TrText('settings.theme_label'),
                trailing: Switch(
                  value: state.darkTheme,
                  onChanged: (value) {
                    var bloc = BlocProvider.of<SettingsBloc>(context);
                    bloc.add(ToggleThemeEvent());
                  },
                ),
              );
            },
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    const snackBar = SnackBar(content: Text('TODO :('));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  child: const TrText(
                    'settings.reboot_button',
                    overflow: TextOverflow.ellipsis,
                    isButton: true,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    const snackBar = SnackBar(content: Text('TODO :('));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const TrText(
                    'settings.shutdown_button',
                    overflow: TextOverflow.ellipsis,
                    isButton: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const DebugView(),
                  ),
                );
              },
              child: const Text('DebugView'))
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildLanguageItems() {
    var l = <String>['en', 'de'].map<DropdownMenuItem<String>>(
      (String value) {
        var data = getLanguageCodeDisplayData(value);
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              SizedBox(
                width: 15,
                height: 15,
                child: data.flag,
              ),
              Container(width: 8),
              Text(data.name)
            ],
          ),
        );
      },
    ).toList();
    return l;
  }
}
