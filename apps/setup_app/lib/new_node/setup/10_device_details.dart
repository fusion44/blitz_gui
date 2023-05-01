// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:common_widgets/common_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:setup_app/new_node/setup/device_scanner_bloc/device_scanner_bloc.dart';

import '../../widgets/find_devices.dart';
import '../bloc/setup_bloc.dart';

class FindDeviceDetailsPage extends StatefulWidget {
  const FindDeviceDetailsPage({Key? key}) : super(key: key);

  @override
  _FindDeviceDetailsPageState createState() => _FindDeviceDetailsPageState();
}

class _FindDeviceDetailsPageState extends State<FindDeviceDetailsPage> {
  final TextEditingController _controller =
      TextEditingController(text: 'http://192.168.1.49/api');

  StreamSubscription<SetupState>? _sub;

  late final DeviceScannerBloc _deviceScannerBloc;

  @override
  void initState() {
    super.initState();
    _deviceScannerBloc = DeviceScannerBloc();
    _deviceScannerBloc.add(DeviceScanStart());
  }

  @override
  void deactivate() {
    _deviceScannerBloc.add(DeviceScanStop());
    super.deactivate();
  }

  @override
  void dispose() async {
    super.dispose();
    await _sub?.cancel();
    await _deviceScannerBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const TrText('setup.appbar_title')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: _buildBody(theme),
        ),
      ),
    );
  }

  Widget _buildBody(ThemeData theme) {
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
          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: tr('setup.input_label.enter_url'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Tooltip(
                  message: tr('setup.btn.scan_qr_with_connection_details'),
                  child: IconButton(
                    onPressed: () {
                      const snackBar = SnackBar(
                        content: Text('Not yet implemented :('),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: const Icon(Icons.qr_code_scanner),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () =>
                context.push('/connect-device', extra: _controller.text),
            child: const TrText('setup.btn.connect_to_api', isButton: true),
          ),
          const SizedBox(height: 32),
          const Text('Scanning your local network for RaspiBlitzes ...'),
          const Divider(),
          _buildFindDevicesWidget(),
        ],
      ),
    );
  }

  BlocProvider<DeviceScannerBloc> _buildFindDevicesWidget() {
    return BlocProvider.value(
      value: _deviceScannerBloc,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FindDevicesWidget((String api) => _controller.text = api),
      ),
    );
  }
}
