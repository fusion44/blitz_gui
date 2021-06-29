import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'setup/00_connect.dart';
import 'setup/01_setup_type.dart';
import 'setup/02_setup_from_scratch.dart';
import 'setup/setup/bloc/setup_bloc.dart';
import 'setup/timeline_appbar.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final _setupBloc = SetupBloc();

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _setupBloc,
      child: Scaffold(
        appBar: TimelineAppBar(_currentStep),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildPage(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _setupBloc.dispose();
  }

  void _onStep00Done() {
    setState(() => _currentStep++);
  }

  Widget _buildPage() {
    if (_currentStep == 0) {
      return Step00Connect(_onStep00Done);
    }
    if (_currentStep == 1) {
      return Container(
        width: double.infinity,
        child: Step01Dashboard(
          onPressed: (choice) {
            if (choice == Step01Dashboard.newNode) {
              return Step02SetupFromScratch();
            } else {
              final snackBar =
                  SnackBar(content: Text('Not yet implemented :('));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
      );
    }
    return Center(child: Text('??? $_currentStep'));
  }
}
