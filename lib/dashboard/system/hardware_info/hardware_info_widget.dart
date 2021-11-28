import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'hardware_info_model.dart';

class HardwareInfoWidget extends StatelessWidget {
  final HardwareInfo info;
  final double dl;
  final double ul;
  const HardwareInfoWidget(this.info, this.dl, this.ul, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            _buildTextFragment('${tr("system.cpu_load")} [%]: ', theme),
            _buildTextFragment(_buildCPULoadText(), theme, Colors.green),
            const Spacer(),
            _buildTextFragment(
                '${tr("system.temperature_short")} [°C]: ', theme),
            _buildTextFragment(_buildTemperatureText(), theme, Colors.green),
          ],
        ),
        Row(
          children: [
            ..._buildMemText(theme),
            const Spacer(),
            _buildTextFragment('${tr('system.hdd_use_short')} [G]: ', theme),
            _buildTextFragment(_buildHDDText(), theme, Colors.green),
          ],
        ),
        Row(children: [
          _buildTextFragment('ssh admin@', theme),
          _buildTextFragment(_getNetworkIP(), theme, Colors.green),
          const Spacer(),
          _buildTextFragment('dl [MiB]: ', theme),
          _buildTextFragment(_buildDlText(), theme, Colors.green),
          _buildTextFragment(' ul [MiB]: ', theme),
          _buildTextFragment(_buildUlText(), theme, Colors.green),
        ]),
      ],
    );
  }

  Widget _buildTextFragment(String text, ThemeData theme, [Color? color]) {
    return TextFragment(
      text,
      color == null
          ? theme.textTheme.bodyText1!
          : theme.textTheme.bodyText1!.copyWith(
              color: color,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.w700,
            ),
    ).toTextWidget();
  }

  String _buildCPULoadText() {
    var txt = '';
    final l = info.cpuPerCpuPercent.length;
    for (var i = 0; i < l; i++) {
      final v = info.cpuPerCpuPercent[i].floor();
      if (v < 10) txt += ' ';
      txt += '$v ';
    }
    return txt;
  }

  String _buildTemperatureText() {
    if (info.temperaturesCelsius.isEmpty) return 'error: no data';

    final totalTemp = info.temperaturesCelsius.reduce(
      (value, element) => Temperature(
        '',
        value.currentTemp + element.currentTemp,
        element.warnTemp,
        element.maxTemp,
      ),
    );

    return '${totalTemp.currentTemp / info.temperaturesCelsius.length} ';
  }

  List<Widget> _buildMemText(ThemeData theme) {
    var used = info.vramUsedBytes! / 1000000;
    var total = info.vramTotalBytes! / 1000000;
    var headerText = 'M';

    if (total > 10000) {
      used /= 1000;
      total /= 1000;
      headerText = 'G';
    }

    return [
      _buildTextFragment('RAM [$headerText]: ', theme),
      _buildTextFragment(
        '${used.toStringAsFixed(1)} / ${total.toStringAsFixed(1)} (${info.vramUsagePercent}%)',
        theme,
        Colors.green,
      ),
    ];
  }

  String _buildHDDText() {
    final d = info.disks.firstWhere((d) => d.mountpoint == '/');
    final used = (d.partitionUsedBytes! / 1000000000).toStringAsFixed(1);
    final total = (d.partitionTotalBytes! / 1000000000).toStringAsFixed(1);
    return '$used / $total (${d.partitionPercent})%';
  }

  String _getNetworkIP([String interfaceName = 'enp4s0']) {
    try {
      final network = info.networks
          .firstWhere((element) => element.interfaceName == interfaceName);
      return network.address ?? tr('system.network_not_found');
    } catch (e) {
      BlitzLog().i(e);
    }
    return tr('system.network_not_found');
  }

  String _buildDlText() {
    return (info.networksBytesReceived! / 1000000).toStringAsFixed(1);
  }

  String _buildUlText() {
    return (info.networksBytesSent! / 1000000).toStringAsFixed(1);
  }
}
