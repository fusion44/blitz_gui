import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../blocs/settings_bloc/settings_bloc.dart';
import '../common/utils.dart';
import '../common/widgets/translated_text.dart';
import 'funds_page.dart';
import 'info_page.dart';
import 'receive_page.dart';
import 'settings_page.dart';

class BlitzDashboard extends StatefulWidget {
  @override
  _BlitzDashboardState createState() => _BlitzDashboardState();
}

class _BlitzDashboardState extends State<BlitzDashboard> {
  int state = 0;

  StreamSubscription<SettingsBaseState> _sub;

  bool _fabVisible = false;

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
      floatingActionButton: _buildFAB(context),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeaderBar(theme),
            _buildBottom(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom(ThemeData theme) {
    return Expanded(
      child: Container(
        child: Row(
          children: [
            _buildSideBar(),
            Expanded(
              child: _buildBody(theme.textTheme.headline4),
            )
          ],
        ),
      ),
    );
  }

  Material _buildSideBar() {
    return Material(
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
                    _fabVisible = false;
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
                    _fabVisible = false;
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
                    _fabVisible = true;
                  });
                },
                child: TrText(
                  'dashboard.funds_button',
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
                    _fabVisible = false;
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
    );
  }

  Material _buildHeaderBar(ThemeData theme) {
    return Material(
      elevation: 3.0,
      child: Container(
        color: Colors.transparent,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 16.0),
            Container(
              height: 20,
              child: Image.asset('assets/RaspiBlitz_Logo_Icon_Negative.png'),
            ),
            SizedBox(width: 8),
            Text(
              'Raspiblitz V1.7',
              style: theme.textTheme.headline5,
              textAlign: TextAlign.center,
            ),
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
        return FundsPage(_setFABVisible);
        break;
      case 3:
        return SettingsPage();
        break;
      default:
        return Text('Other State');
    }
  }

  void _setFABVisible(bool visible) {
    setState(() {
      _fabVisible = visible;
    });
  }

  Visibility _buildFAB(BuildContext context) {
    return Visibility(
      visible: _fabVisible,
      child: FloatingActionButton(
        mini: true,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ReceivePage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}