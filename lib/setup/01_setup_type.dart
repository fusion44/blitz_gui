import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

import '../common/widgets/translated_text.dart';

class Step01Dashboard extends StatelessWidget {
  static const String newNode = 'newNode';
  static const String migration = 'migration';
  static const String recover = 'recover';

  final Function(String) onPressed;

  const Step01Dashboard({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        TrText('setup.choose_setup_type', style: theme.textTheme.headline5),
        SizedBox(height: 8),
        Wrap(
          spacing: 25,
          runSpacing: 25,
          children: [
            _buildButton(
              theme: theme,
              icon: Mdi.bitcoin,
              btnLabel: TrText('setup.btn.new_node_from_scratch'),
              description: TrText(
                'setup.btn.new_node_from_scratch_desc',
                textAlign: TextAlign.center,
              ),
              onPressed: () => onPressed(newNode),
            ),
            _buildButton(
              theme: theme,
              icon: Mdi.wrench,
              btnLabel: TrText('setup.btn.migrate'),
              description: TrText(
                'setup.btn.migrate_desc',
                textAlign: TextAlign.center,
              ),
              onPressed: () => onPressed(migration),
            ),
            _buildButton(
              theme: theme,
              icon: Icons.import_export,
              btnLabel: TrText('setup.btn.recover'),
              description: TrText(
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
    ThemeData theme,
    Widget btnLabel,
    IconData icon,
    Widget description,
    double size = 200,
    Function onPressed,
  }) {
    final btn = Container(
      width: size,
      height: size,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) => theme.highlightColor,
          ),
        ),
        onPressed: onPressed,
        icon: Icon(icon),
        label: btnLabel,
      ),
    );

    if (description != null) {
      return Container(
          width: size,
          child: Column(children: [btn, SizedBox(height: 8.0), description]));
    } else {
      return btn;
    }
  }
}
