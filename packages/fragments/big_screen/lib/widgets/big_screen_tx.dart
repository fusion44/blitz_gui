import 'package:flutter/material.dart';

import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_transactions_fragment/list_transactions.dart';

class BigScreenTxWidget extends StatelessWidget {
  static const txListMinWidth = 350.0;
  static const txListMaxWidth = 650.0;
  const BigScreenTxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: LayoutBuilder(
        builder: ((context, constraints) {
          final width = constraints.maxWidth;
          if (width < 1200) {
            return Column(
              children: [
                Text(
                  'Overview Widget goes here $width',
                  style: theme.textTheme.headline3,
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    constraints: const BoxConstraints(
                      minWidth: txListMinWidth,
                      maxWidth: txListMaxWidth,
                    ),
                    child:
                        FundsPage((visible) => debugPrint(visible.toString())),
                  ),
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(
                  child: BlocBuilder<LightningInfoBloc, LightningInfoBaseState>(
                    builder: _buildBalanceWidget,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: txListMaxWidth),
                    child:
                        FundsPage((visible) => debugPrint(visible.toString())),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 32),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.arrow_downward_outlined),
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text('Not implemented yet :('),
                                ),
                              );
                          },
                          label: const TrText('wallet.receive_btn'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              blitzReceiveButton,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.arrow_upward_outlined),
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text('Not implemented yet :('),
                                ),
                              );
                          },
                          label: const TrText('wallet.send_btn'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              blitzSendButton,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget _buildBalanceWidget(
    BuildContext context,
    LightningInfoBaseState state,
  ) {
    if (state is LightningInfoInitial) {
      return const Text('loading');
    }

    if (state is LightningInfoState) {
      return Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: ShowBalanceWidget(state.walletBalance),
      );
    }

    return Text('Unknown state: $state');
  }
}
