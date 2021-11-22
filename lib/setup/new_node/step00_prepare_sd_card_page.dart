import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'prepare_sd_card/flash_sd_card.dart';

class PrepareSDCardPage extends StatefulWidget {
  final Function(int) onStepDone;

  const PrepareSDCardPage(this.onStepDone, {Key? key}) : super(key: key);

  @override
  _PrepareSDCardPageState createState() => _PrepareSDCardPageState();
}

class _PrepareSDCardPageState extends State<PrepareSDCardPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SizedBox(
        width: 400,
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            TrText('setup.flash_sd_header', style: theme.textTheme.headline4!),
            const SizedBox(height: 8.0),
            const TrText(
              'setup.question.existing_sd_or_flash_new',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _onNewSDCard,
                  child:
                      const TrText('setup.btn.flash_sd_card', isButton: true),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _onExistingSDCard,
                  child: const TrText(
                    'setup.btn.skip_to_next_step',
                    isButton: true,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onNewSDCard() async {
    final res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => const FlashSDCardPage()),
    );

    if (res != null && res is bool && res) {
      widget.onStepDone(0);
    }
  }

  void _onExistingSDCard() {
    // TODO: implement me
    const snackBar = SnackBar(content: Text('TODO :('));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
