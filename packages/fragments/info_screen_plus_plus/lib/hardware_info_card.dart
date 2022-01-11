import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart';

class HardwareInfoCard extends StatelessWidget {
  const HardwareInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HardwareInfoBloc, HardwareInfoBaseState>(
      builder: (context, state) {
        if (state is HardwareInfoInitial) {
          return const Text('loading ...');
        } else if (state is HardwareInfoState) {
          final i = state.info;
          return BlitzCard(
            title: 'Hardware',
            subtitle: ' up: ${format(
              DateTime.fromMicrosecondsSinceEpoch(
                  i.bootTimeTimestamp * 1000 * 1000),
            )}',
            child: Column(
              children: [
                _buildRow(
                    'system.temperature', '${i.systemTemp.toString()} °C'),
                if (i.temperaturesCelsius.isNotEmpty)
                  _buildRow(
                    'system.cpu_temperatures',
                    '${i.temperaturesCelsius.toString()} °C',
                  ),
                _buildRow(
                    'system.cpu_usage_overall', '${i.cpuOverallPercent} %'),
                _buildRow('system.cpu_usage_per_cpu_short',
                    '${i.cpuPerCpuPercent} %'),
                _buildRow('system.hdd_use_short',
                    '${i.disks.first.partitionPercent} %'),
                _buildRow('system.ram_usage', '${i.vramUsagePercent} %'),
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
