import 'package:flutter/material.dart';

import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'widgets/blockchain_status.dart';

class BitcoinInfoCard extends StatelessWidget {
  const BitcoinInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BitcoinInfoBloc, BitcoinInfoBaseState>(
      builder: (context, state) {
        if (state is BitcoinInfoInitial) {
          return const SpinKitChasingDots(color: Colors.red);
        } else if (state is BitcoinInfoState) {
          final i = state.info;

          return BlitzCard(
            title: 'Bitcoin',
            subtitle: i.subversion,
            child: Column(
              children: [
                BlockchainStatus(info: i),
                _buildRow(
                  'bitcoin.connections_in',
                  trp('bitcoin.connections_no_appendix', i.connectionsIn),
                ),
                _buildRow(
                  'bitcoin.connections_out',
                  trp('bitcoin.connections_no_appendix', i.connectionsOut),
                ),
                _buildRow(
                  'bitcoin.blockchain_disk_space_used',
                  (i.sizeOnDisk / 1000 / 1000 / 1000)
                          .roundToDouble()
                          .toString() +
                      ' GB',
                ),
              ],
            ),
          );
        }

        return Center(child: Text('Error. Unknown BitcoinInfoState: $state'));
      },
    );
  }

  Widget _buildRow(String stringIdLeft, String right) {
    return Row(
      children: [
        TrText(stringIdLeft),
        Expanded(
          child: Text(
            right,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
