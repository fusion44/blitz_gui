import 'package:flutter/material.dart';

import 'package:common/common.dart';

class SetupInfoBox extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isError;
  final Map<String, dynamic> args;
  final Widget? action;

  const SetupInfoBox({
    Key? key,
    required this.text,
    this.icon = Icons.info_outline,
    this.isError = false,
    this.args = const <String, dynamic>{},
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: action != null ? _buildWithAction(theme) : _buildTextRow(theme),
      ),
    );
  }

  Widget _buildWithAction(ThemeData theme) {
    return Column(
      children: [
        _buildTextRow(theme),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 52.0),
          child: action!,
        ),
      ],
    );
  }

  Widget _buildTextRow(ThemeData theme) {
    return Row(
      children: [
        Icon(icon, size: 48, color: isError ? theme.errorColor : null),
        const SizedBox(width: 8),
        Flexible(
          child: TrText(text, args: args),
        ),
      ],
    );
  }
}
