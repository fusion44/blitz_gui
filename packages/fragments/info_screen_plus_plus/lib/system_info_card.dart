import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SystemInfoCard extends StatelessWidget {
  const SystemInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemInfoBloc, SystemInfoBaseState>(
      builder: (context, state) {
        if (state is SystemInfoInitial) {
          return const SpinKitChasingDots(color: Colors.red);
        } else if (state is SystemInfoState) {
          final i = state.info;
          return BlitzCard(
            title: tr('system.next_gen_info_screen_card_header'),
            subtitle: i.platformVersion,
            child: Column(
              children: [
                _buildRow('system.platform', i.platform.name.toUpperCase()),
                _buildRow('system.api_version', i.apiVersion),
                _buildRow('system.api_url', i.lanApi),
                _buildRow('SSH', i.sshAddress),
                _buildRow('system.main_chain', i.chain),
                _buildRow('system.health', i.health),
              ],
            ),
          );
        }
        return Container();
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
