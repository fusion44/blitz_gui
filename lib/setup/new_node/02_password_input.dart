import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as v;

class PasswordInputPage extends StatefulWidget {
  @override
  _PasswordInputPageState createState() => _PasswordInputPageState();
}

class _PasswordInputPageState extends State<PasswordInputPage>
    with TickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _passAController = TextEditingController();
  final _passBController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Setting up your new Blitz')),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Please enter the name of your new RaspiBlitz:\none word, keep characters basic & not too long',
                    style: theme.textTheme.subtitle1,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!v.isAlphanumeric(value)) {
                        return 'Only alpha numeric names allowed';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Master User Password',
                    style: theme.textTheme.subtitle1,
                  ),
                  TextFormField(
                    controller: _passAController,
                    decoration: InputDecoration(labelText: 'Password A'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value.length < 8) {
                        return 'Password must be longer than eight characters';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Password A control'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value != _passAController.text) {
                        return 'Password doesn\'t match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Blockchain RPC Password',
                    style: theme.textTheme.subtitle1,
                  ),
                  TextFormField(
                    controller: _passBController,
                    decoration: InputDecoration(labelText: 'Password B'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value.length < 8) {
                        return 'Password must be longer than eight characters';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Password B control'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value != _passAController.text) {
                        return 'Password doesn\'t match';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                    },
                    child: Text('NEXT'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
