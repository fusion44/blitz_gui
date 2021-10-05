import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/subscription_repository.dart';
import '../common/widgets/translated_text.dart';
import 'add_invoice_page.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({Key? key}) : super(key: key);

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
                SizedBox(
                  width: 150,
                  height: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext c) =>
                              RepositoryProvider<SubscriptionRepository>.value(
                            value: RepositoryProvider.of(context),
                            child: const AddInvoicePage(),
                          ),
                        ),
                      );
                    },
                    child: TrText(
                      'wallet.lightning.short',
                      style: theme.textTheme.headline5!,
                      isButton: true,
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: TrText(
                      'wallet.onchain.short',
                      style: theme.textTheme.headline5!,
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
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 8.0),
            SizedBox(
              height: 20,
              child: Image.asset('assets/RaspiBlitz_Logo_Icon_Negative.png'),
            ),
            const SizedBox(width: 8),
            Text(
              'Receive Funds',
              style: theme.textTheme.headline5!,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
