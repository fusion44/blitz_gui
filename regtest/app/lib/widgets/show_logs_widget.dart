import 'dart:async';

import 'package:flutter/material.dart';
import 'package:regtest_core/core.dart';

class ShowLogsWidget extends StatefulWidget {
  final String containerId;
  const ShowLogsWidget(this.containerId, {super.key});

  @override
  State<ShowLogsWidget> createState() => _ShowLogsWidgetState();
}

class _ShowLogsWidgetState extends State<ShowLogsWidget> {
  bool loaded = false;
  final List<String> logLines = [];

  String errorMessage = '';
  final ScrollController _controller = ScrollController();

  StreamSubscription<String>? _sub;

  @override
  void dispose() async {
    super.dispose();
    await _sub?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _warmup();
  }

  Future<void> _warmup() async {
    final container = NetworkManager().findContainerById(widget.containerId);
    if (container == null) {
      return setState(() => errorMessage = 'Container not found');
    }

    final logs = await container.fetchLogs();

    _sub = container.logStream.listen((event) {
      setState(() => logLines.add(event));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });

    setState(() {
      logLines.add(logs);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    return SingleChildScrollView(
      controller: _controller,
      child: SelectableText(logLines.join('\n')),
    );
  }
}
