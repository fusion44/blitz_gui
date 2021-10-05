import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

import '../common/widgets/translated_text.dart';

class SetupTypeSwitch extends StatelessWidget {
  static const String newNode = 'newNode';
  static const String migration = 'migration';
  static const String recover = 'recover';

  final Function(String) onPressed;

  const SetupTypeSwitch({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        TrText('setup.choose_setup_type', style: theme.textTheme.headline5!),
        const SizedBox(height: 8),
        Wrap(
          spacing: 25,
          runSpacing: 25,
          children: [
            _buildButton(
              theme: theme,
              icon: Mdi.bitcoin,
              btnLabel: const TrText('setup.btn.new_node_from_scratch'),
              description: const TrText(
                'setup.btn.new_node_from_scratch_desc',
                textAlign: TextAlign.center,
              ),
              onPressed: () => onPressed(newNode),
            ),
            _buildButton(
              theme: theme,
              icon: Mdi.wrench,
              btnLabel: const TrText('setup.btn.migrate'),
              description: const TrText(
                'setup.btn.migrate_desc',
                textAlign: TextAlign.center,
              ),
              onPressed: () => onPressed(migration),
            ),
            _buildButton(
              theme: theme,
              icon: Icons.import_export,
              btnLabel: const TrText('setup.btn.recover'),
              description: const TrText(
                'setup.btn.recover_desc',
                textAlign: TextAlign.center,
              ),
              onPressed: () => onPressed(recover),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildButton({
    required ThemeData theme,
    required Widget btnLabel,
    required IconData icon,
    Widget? description,
    double size = 200,
    required Function onPressed,
  }) {
    final btn = SizedBox(
      width: size,
      height: size,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) => theme.highlightColor,
          ),
        ),
        onPressed: () => onPressed(),
        icon: Icon(icon),
        label: btnLabel,
      ),
    );

    if (description != null) {
      return SizedBox(
        width: size,
        child: Column(children: [
          btn,
          const SizedBox(height: 8.0),
          description,
        ]),
      );
    } else {
      return btn;
    }
  }
}
