import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'setup/00_connect.dart';
import 'setup/01_setup_type.dart';
import 'setup/02_setup_from_scratch.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  // Step 0: Connect to node
  // Step 1: Chose setup mode

  int _currentStep = 0;
  bool _step0Done = false;

  bool _currentStepDone = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroductionScreen(
        pages: _buildPages(),
        showNextButton: _currentStepDone,
        freeze: !_currentStepDone,
        next: Text('NEXT'),
        onChange: (next) {
          setState(() {
            _currentStep = next;
          });
        },
        showDoneButton: false,
      ),
    );
  }

  List<PageViewModel> _buildPages() {
    if (_currentStep == 0) {
      return [
        _buildStep0Model(),
        if (_step0Done) _buildStep1Model(),
      ];
    } else if (_currentStep == 1) {
      return [
        _buildStep0Model(),
        _buildStep1Model(),
      ];
    } else {
      return [];
    }
  }

  void _onStep00Done() {
    setState(() {
      _currentStepDone = true;
      _step0Done = true;
    });
  }

  PageViewModel _buildStep0Model() {
    return PageViewModel(
      title: 'Raspiblitz Setup',
      bodyWidget: Step00Connect(_onStep00Done),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        imagePadding: EdgeInsets.zero,
      ),
    );
  }

  PageViewModel _buildStep1Model() {
    return PageViewModel(
      title: 'Raspiblitz Setup',
      bodyWidget: Step01Dashboard(onPressed: (choice) {
        if (choice == Step01Dashboard.newNode) {
          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Step02SetupFromScratch(),
            ),
          );
        } else {
          final snackBar = SnackBar(content: Text('Not yet implemented :('));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        imagePadding: EdgeInsets.zero,
      ),
    );
  }
}
