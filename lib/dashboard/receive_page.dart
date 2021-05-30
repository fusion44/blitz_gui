import 'dart:ui';

import 'package:flutter/material.dart';

import '../common/widgets/translated_text.dart';
import 'add_invoice_page.dart';

class ReceivePage extends StatefulWidget {
  @override
  _ReceivePageState createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          _buildHeaderBar(theme),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => AddInvoicePage(),
                        ),
                      );
                    },
                    child: TrText(
                      'wallet.lightning.short',
                      style: theme.textTheme.headline5,
                      isButton: true,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: TrText(
                      'wallet.onchain.short',
                      style: theme.textTheme.headline5,
                      isButton: true,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
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
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(width: 8.0),
            Container(
              height: 20,
              child: Image.asset('assets/RaspiBlitz_Logo_Icon_Negative.png'),
            ),
            SizedBox(width: 8),
            Text(
              'Receive Funds',
              style: theme.textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
