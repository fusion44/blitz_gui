import 'package:blitz_gui/setup/00_connect.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'setup/01_setup_type.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  int _currentStep = 0;
  bool _currentStepDone = false;
  GraphQLClient _gqlClient;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroductionScreen(
        pages: _buildPages(),
        showNextButton: _currentStepDone,
        freeze: !_currentStepDone,
        next: Text('NEXT'),
        done: Text('done btd'),
        onDone: () => print('done'),
      ),
    );
  }

  List<PageViewModel> _buildPages() {
    return [
      PageViewModel(
        title: 'Raspiblitz Setup',
        bodyWidget: Step00Connect(_onStep00Done),
        decoration: const PageDecoration(
          titleTextStyle:
              TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
          descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          imagePadding: EdgeInsets.zero,
        ),
      ),
      PageViewModel(
        title: 'Raspiblitz Setup',
        bodyWidget: Step01Dashboard(onPressed: (choice) => print(choice)),
        decoration: const PageDecoration(
          titleTextStyle:
              TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
          descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          imagePadding: EdgeInsets.zero,
        ),
      ),
    ];
  }

  void _onStep00Done(GraphQLClient client) {
    setState(() {
      _currentStepDone = true;
      _gqlClient = client;
    });
  }
}
