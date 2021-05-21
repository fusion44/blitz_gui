import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../blocs/settings_bloc/settings_bloc.dart';
import '../common/utils.dart';
import '../common/widgets/translated_text.dart';

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
              return ListTile(
                title: TrText('settings.language_label'),
                trailing: DropdownButton(
                  value: state.langCode,
                  onChanged: (value) {
                    BlocProvider.of<SettingsBloc>(context).add(
                      ChangeLanguageEvent(value),
                    );
                  },
                  items: _buildLanguageItems(),
                ),
              );
            },
          ),
          BlocBuilder<SettingsBloc, SettingsState>(
            bloc: BlocProvider.of(context),
            builder: (context, state) {
              return ListTile(
                title: TrText('settings.theme_label'),
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
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    final snackBar = SnackBar(content: Text('TODO :('));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  child: TrText(
                    'settings.reboot_button',
                    overflow: TextOverflow.ellipsis,
                    isButton: true,
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Container(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    final snackBar = SnackBar(content: Text('TODO :('));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: TrText(
                    'settings.shutdown_button',
                    overflow: TextOverflow.ellipsis,
                    isButton: true,
                  ),
                ),
              )
            ],
          )
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
