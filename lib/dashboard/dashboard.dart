import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'info_page.dart';

class BlitzDashboard extends StatefulWidget {
  @override
  _BlitzDashboardState createState() => _BlitzDashboardState();
}

class _BlitzDashboardState extends State<BlitzDashboard> {
  int state = 0;
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
                        width: 75,
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
                                child: Text('INFO'),
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
                                child: Text('NODE'),
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
                                child: Text('INVOICE'),
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
                                child: Text('OFF'),
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
        return Center(
          child: Column(
            children: [
              SizedBox(height: 32.0),
              Container(
                height: 50.0,
                width: 100.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  child: Text('REBOOT'),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 50.0,
                width: 100.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text('Shutdown'),
                ),
              ),
            ],
          ),
        );
        break;
      default:
        return Text('Other State');
    }
  }
}
