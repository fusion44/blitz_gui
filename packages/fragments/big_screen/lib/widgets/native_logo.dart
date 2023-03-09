import 'package:flutter/material.dart';

class NativeLogo extends StatelessWidget {
  final String version;
  const NativeLogo({Key? key, required this.version}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const SizedBox(
          height: 36,
          child: Text(
            'Na',
            style: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Column(
          children: [
            Text(
              'NativeAPI',
              style: theme.textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              version,
              style: theme.textTheme.bodySmall,
            )
          ],
        ),
      ],
    );
  }
}
