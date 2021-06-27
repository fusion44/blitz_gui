import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'setup/bloc/setup_bloc.dart';

class Step00Connect extends StatefulWidget {
  final Function() onDone;
  Step00Connect(this.onDone);

  @override
  _Step00ConnectState createState() => _Step00ConnectState();
}

class _Step00ConnectState extends State<Step00Connect> {
  final TextEditingController _controller =
      TextEditingController(text: 'http://127.0.0.1:8000/');

  StreamSubscription<SetupState> _sub;

  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<SetupBloc>(context);
    _sub = bloc.stream.listen((state) {
      if (state is ConnectingNodeSuccess) {
        widget.onDone();
      }
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await _sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SetupBloc, SetupState>(
      builder: (context, state) {
        if (state is SetupInitial) {
          return _buildBody(theme);
        } else if (state is ConnectingNodeState) {
          return _buildBody(theme, working: true);
        } else if (state is ConnectingNodeError) {
          return _buildBody(
            theme,
            error: state.errorMessage,
          );
        } else if (state is ConnectingNodeSuccess) {
          var buffer = StringBuffer();
          for (var key in state.state.keys) {
            buffer.writeln(key + ': ' + state.state[key].toString());
          }

          return _buildBody(theme, successText: buffer.toString());
        }
        return Center(child: Text('Unknown $state'));
      },
    );
  }

  Column _buildBody(
    ThemeData theme, {
    String error = '',
    String successText = '',
    bool working = false,
  }) {
    error ??= '';

    return Column(
      children: [
        Text('Connect to your Raspiblitz', style: theme.textTheme.headline5),
        SizedBox(height: 8),
        TextField(
          controller: _controller,
          enabled: !working,
          decoration: InputDecoration(
            labelText: 'Enter the URL of your Blitz here',
          ),
        ),
        SizedBox(height: 16),
        error.isNotEmpty ? Text(error) : Container(),
        successText.isNotEmpty
            ? Text(
                'TODO: Make it look nicer',
                style: theme.textTheme.bodyText1.copyWith(
                  color: Colors.yellow,
                ),
              )
            : Container(),
        successText.isNotEmpty
            ? Text(
                'Response:',
                style: theme.textTheme.headline6,
              )
            : Container(),
        successText.isNotEmpty ? Text(successText, maxLines: 5) : Container(),
        successText.isNotEmpty
            ? Text(
                'You may proceed to next screen',
                style: theme.textTheme.headline6,
              )
            : Container(),
        SizedBox(height: 16),
        successText.isEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: working ? null : () => _connect(),
                    child: Text('connect'.toUpperCase()),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: working ? null : () => _scan_qr(),
                    child: Text('scan qr'.toUpperCase()),
                  )
                ],
              )
            : Container(),
      ],
    );
  }

  void _connect() async {
    BlocProvider.of<SetupBloc>(context).add(
      ConnectNodeEvent(_controller.text),
    );
  }

  void _scan_qr() {
    _controller.text = 'some_address.onion';
  }
}
