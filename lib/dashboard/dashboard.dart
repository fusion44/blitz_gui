import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../blocs/settings_bloc/settings_bloc.dart';
import '../common/utils.dart';
import '../common/widgets/translated_text.dart';
import 'info_page.dart';
import 'settings_page.dart';

class BlitzDashboard extends StatefulWidget {
  @override
  _BlitzDashboardState createState() => _BlitzDashboardState();
}

class _BlitzDashboardState extends State<BlitzDashboard> {
  int state = 0;

  StreamSubscription<SettingsState> _sub;

  @override
  void initState() {
    changeLocale(context, 'en');
    updateTimeAgoLib('en');

    final bloc = BlocProvider.of<SettingsBloc>(context);
    _sub = bloc.stream.listen((state) {
      changeLocale(context, state.langCode);
      updateTimeAgoLib(state.langCode);
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        // color: Colors.cyan,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              elevation: 3.0,
              child: Container(
                // color: Colors.black,
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      child: Image.file(
                        File(
                          '/home/pi/blitz_gui/RaspiBlitz_Logo_Icon_Negative.png',
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Raspiblitz V1.7 - bitcoin - mainnet',
                      style: theme.textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Material(
                      elevation: 4.0,
                      child: Container(
                        width: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    state = 0;
                                  });
                                },
                                child: TrText(
                                  'dashboard.info_button',
                                  overflow: TextOverflow.ellipsis,
                                  isButton: true,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    state = 1;
                                  });
                                },
                                child: TrText(
                                  'dashboard.node_button',
                                  overflow: TextOverflow.ellipsis,
                                  isButton: true,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    state = 2;
                                  });
                                },
                                child: TrText(
                                  'dashboard.invoice_button',
                                  overflow: TextOverflow.ellipsis,
                                  isButton: true,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    state = 3;
                                  });
                                },
                                child: TrText(
                                  'dashboard.settings_button',
                                  overflow: TextOverflow.ellipsis,
                                  isButton: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                            child: _buildBody(theme.textTheme.headline4)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(TextStyle styl) {
    final theme = Theme.of(context);
    switch (state) {
      case 0:
        return InfoPage();
        break;
      case 1:
        return QrImage(
          backgroundColor: Colors.grey[300],
          data: "1234567890",
          version: QrVersions.auto,
          size: 180.0,
        );
        break;
      case 2:
        return SingleChildScrollView(
          child: Column(
            children: [
              Text('GIMME\nINVOICE', style: styl),
              Divider(),
              Text('GIMME\nINVOICE', style: styl),
              Divider(),
              Text('GIMME\nINVOICE', style: styl),
              Divider(),
              Text('GIMME\nINVOICE', style: styl),
              Divider(),
              Text('GIMME\nINVOICE', style: styl),
              Divider(),
              Text('GIMME\nINVOICE', style: styl),
              Divider(),
              Text('GIMME\nINVOICE', style: styl),
              Divider(),
              Text('GIMME\nINVOICE', style: styl),
            ],
          ),
        );
        break;
      case 3:
        return SettingsPage();
        break;
      default:
        return Text('Other State');
    }
  }
}
