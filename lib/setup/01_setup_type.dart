import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class Step01Dashboard extends StatelessWidget {
  static final String newNode = 'newNode';
  static final String migration = 'migration';
  static final String recover = 'recover';

  final Function(String) onPressed;

  const Step01Dashboard({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text('Hard Drive setup', style: theme.textTheme.headline5),
        SizedBox(height: 8),
        Container(
          child: Wrap(
            spacing: 25,
            runSpacing: 25,
            children: [
              _buildButton(
                theme: theme,
                icon: Mdi.bitcoin,
                btnLabel: Text('BITCOIN / LIGHTNING'),
                description: _buildText('Setup the node from scratch'),
                onPressed: () => onPressed(newNode),
              ),
              _buildButton(
                theme: theme,
                icon: Mdi.wrench,
                btnLabel: Text('MIGRATION'),
                description: _buildText(
                  'Upload a migration file from another Blitz',
                ),
                onPressed: () => onPressed(migration),
              ),
              _buildButton(
                theme: theme,
                icon: Icons.import_export,
                btnLabel: Text('RECOVER'),
                description: _buildText(
                  'Use data found on the connected external hard drive.',
                ),
                onPressed: () => onPressed(recover),
              )
            ],
          ),
        ),
      ],
    );
  }

  Text _buildText(String text, [TextAlign align = TextAlign.center]) {
    return Text(text, maxLines: 2, textAlign: align);
  }

  Widget _buildButton({
    ThemeData theme,
    Widget btnLabel,
    IconData icon,
    Widget description,
    double size = 250,
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
