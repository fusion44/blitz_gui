import 'package:flutter/material.dart';

import 'setup_type_switch.dart';

class SetupHome extends StatelessWidget {
  final Function(String) onDone;

  const SetupHome(this.onDone, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: SetupTypeSwitch(
              onPressed: (choice) {
                if (choice == SetupTypeSwitch.newNode) {
                  onDone(SetupTypeSwitch.newNode);
                } else {
                  const snackBar =
                      SnackBar(content: Text('Not yet implemented :('));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
