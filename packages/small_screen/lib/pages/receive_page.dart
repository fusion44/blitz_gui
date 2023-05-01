// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:common_widgets/common_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_repository/subscription_repository.dart';

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
                      style: theme.textTheme.headlineSmall!,
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
                      style: theme.textTheme.headlineSmall!,
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
              style: theme.textTheme.headlineSmall!,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
