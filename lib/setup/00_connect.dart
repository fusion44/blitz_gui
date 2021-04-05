import 'package:animate_do/animate_do.dart' as anim;
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class Step00Connect extends StatefulWidget {
  final Function(GraphQLClient) onDone;
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
      TextEditingController(text: 'http://192.168.1.39:8081/query');

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

    final _httpLink = HttpLink(_controller.text);
    final _wsLink = WebSocketLink('${_controller.text}/ws');
    final _link = Link.split(
      (request) => request.isSubscription,
      _wsLink,
      _httpLink,
    );

    final client = GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );

    final res = await client.query(QueryOptions(document: gql(r' { hello }')));

    _connecting = false;
    _triedConnecting = true;

    setState(() {
      if (res.hasException) {
        _connectionError = true;
        if (res.exception.graphqlErrors.isNotEmpty) {
          _errorMessage = res.exception.graphqlErrors[0].message;
        } else if (res.exception.linkException != null) {
          _errorMessage = res.exception.linkException.toString();
        }
      } else {
        _connectionError = false;
        widget.onDone(client);
      }
    });
  }
}
