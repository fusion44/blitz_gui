import 'package:flutter/material.dart';
import 'package:subscription_repository/subscription_repository.dart';

class EventFilterDlgContent extends StatefulWidget {
  final ValueNotifier<List<SseEventTypes>> _notifier;

  const EventFilterDlgContent(this._notifier, {super.key});

  @override
  State<EventFilterDlgContent> createState() => _EventFilterDlgContentState();
}

class _EventFilterDlgContentState extends State<EventFilterDlgContent> {
  final _filter = <SseEventTypes>[];

  @override
  void initState() {
    _filter.addAll(widget._notifier.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildFilterColumn();
  }

  Widget _buildFilterColumn() {
    return Column(children: [
      for (final v in SseEventTypes.values)
        Row(children: [
          Checkbox(
            value: _filter.contains(v) ? true : false,
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                _filter.contains(v) ? _filter.remove(v) : _filter.add(v);

                widget._notifier.value = _filter;
              });
            },
          ),
          Text(v.name)
        ]),
    ]);
  }
}
