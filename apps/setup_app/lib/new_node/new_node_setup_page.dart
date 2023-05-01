// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/setup_bloc.dart';
import 'setup/10_device_details.dart';

class NewNodeSetupPage extends StatefulWidget {
  const NewNodeSetupPage({Key? key}) : super(key: key);

  @override
  _NewNodeSetupPageState createState() => _NewNodeSetupPageState();
}

class _NewNodeSetupPageState extends State<NewNodeSetupPage> {
  final _setupBloc = NewNodeSetupBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _setupBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('New Node Setup')),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: FindDeviceDetailsPage(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _setupBloc.close();
  }
}
