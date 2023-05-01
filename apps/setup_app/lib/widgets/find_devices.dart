import 'package:flutter/material.dart';

import 'package:common_widgets/common_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../new_node/setup/device_scanner_bloc/device_scanner_bloc.dart';

class FindDevicesWidget extends StatelessWidget {
  final Function(String) onDeviceSelected;

  const FindDevicesWidget(this.onDeviceSelected, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceScannerBloc, DeviceScannerState>(
      builder: (context, state) {
        if (state is DeviceScannerInitial) {
          return const Text('Scanning... 0.0%');
        } else if (state is NetworkScanProgressState ||
            state is NetworkScanFinishedState) {
          return _buildScanningState(state, context);
        }
        return Text('Unknown $state');
      },
    );
  }

  Widget _buildScanningState(DeviceScannerState state, BuildContext context) {
    Widget? header;
    Widget? icon;
    List devices = [];
    if (state is NetworkScanProgressState) {
      header = TrText(
        'setup.scanning_network_header',
        args: {
          'progress': (state.progress * 100).floor(),
          'numDevices': state.devices.length,
        },
        style: Theme.of(context).textTheme.headlineSmall!,
      );
      icon = const RepaintBoundary(
        child: SpinKitSpinningLines(color: Colors.amberAccent, size: 32.0),
      );
      devices = state.devices;
    }
    if (state is NetworkScanFinishedState) {
      header = TrText(
        'setup.scan_network_finished_header',
        args: {'numDevices': state.devices.length},
        style: Theme.of(context).textTheme.headlineSmall!,
      );
      icon = const Icon(Icons.done_all, size: 32.0);

      devices = state.devices;
    }
    if (header == null || icon == null) {
      return throw ArgumentError(
        'State must be NetworkScanProgressState or NetworkScanFinishedState',
      );
    }

    final headerRow = Row(
      children: [
        const SizedBox(width: 12.0),
        icon,
        const SizedBox(width: 28.0),
        header,
      ],
    );

    return Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: const Duration(milliseconds: 375),
        childAnimationBuilder: (widget) => SlideAnimation(
          horizontalOffset: 50.0,
          child: FadeInAnimation(
            child: widget,
          ),
        ),
        children: [
          headerRow,
          for (final device in devices)
            ListTile(
              leading: const Icon(MdiIcons.lightningBoltCircle),
              title: Text(device.api),
              subtitle: Text(
                'Setup phase: ${device.setupStatus.setupPhase}',
              ),
              onTap: () => onDeviceSelected(device.api),
            )
        ],
      ),
    );
  }
}
