import 'package:flutter/material.dart';

class RaspiBlitzLogo extends StatelessWidget {
  const RaspiBlitzLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
          height: 36,
          child: Image.asset('assets/RaspiBlitz_Logo_Icon_Negative.png'),
        ),
        const SizedBox(width: 8.0),
        Column(
          children: [
            Text(
              'RaspiBlitz',
              style: theme.textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'v1.7.1',
              style: theme.textTheme.bodySmall,
            )
          ],
        ),
      ],
    );
  }
}
