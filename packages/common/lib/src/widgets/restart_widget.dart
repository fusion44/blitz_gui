// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RestartWidget extends StatefulWidget {
  final Widget child;
  const RestartWidget({Key? key, required this.child}) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  Future<void> restartApp() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() => key = UniqueKey());
    });
  }

  @override
  Widget build(BuildContext context) =>
      KeyedSubtree(key: key, child: widget.child);
}
