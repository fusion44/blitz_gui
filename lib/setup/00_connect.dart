import 'package:animate_do/animate_do.dart' as anim;
import 'package:flutter/material.dart';

class Step00Connect extends StatefulWidget {
  final Function() onDone;
  Step00Connect(this.onDone);

  @override
  _Step00ConnectState createState() => _Step00ConnectState();
}

class _Step00ConnectState extends State<Step00Connect> {
  bool _connecting = false;
  bool _triedConnecting = false;

  bool _connectionError = false;
  String _errorMessage = '';

  final TextEditingController _controller =
      // TextEditingController(text: 'http://192.168.1.39:8081/query');
      TextEditingController(text: 'http://localhost:8081/query');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text('Connect to your Raspiblitz', style: theme.textTheme.headline5),
        SizedBox(height: 8),
        TextField(
          controller: _controller,
          enabled: !_connecting,
          decoration:
              InputDecoration(labelText: 'Enter the URL of your Blitz here'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _connecting ? null : () => _connect(),
          child: Text('connect'.toUpperCase()),
        ),
        if (!_connectionError && _triedConnecting)
          anim.ElasticIn(
            child: Text(
              'Amazing, your Raspiblitz said Hello!\nYou may proceed to the next step.',
              style: theme.textTheme.headline4,
            ),
          ),
        if (_connectionError && _triedConnecting)
          Column(
            children: [
              SizedBox(height: 8),
              anim.ElasticIn(
                child: Text(
                  'There appears to be a problem connecting to your Blitz :(',
                  style: theme.textTheme.headline4,
                ),
              ),
              SizedBox(height: 8),
              anim.ElasticIn(
                child: Text(_errorMessage, style: theme.textTheme.headline6),
              )
            ],
          )
      ],
    );
  }

  void _connect() async {
    setState(() {
      _triedConnecting = true;
      _connectionError = false;
      _connecting = true;
    });

    _connecting = false;
    _triedConnecting = true;

    setState(() {
      widget.onDone();
    });
  }
}
