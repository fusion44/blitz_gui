import 'package:flutter/material.dart';

import '../../common/widgets/translated_text.dart';
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
      child: Container(
        width: 400,
        child: Column(
          children: [
            SizedBox(height: 8.0),
            TrText('setup.flash_sd_header', style: theme.textTheme.headline4!),
            SizedBox(height: 8.0),
            TrText(
              'setup.question.existing_sd_or_flash_new',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _onNewSDCard,
                  child: TrText('setup.btn.flash_sd_card', isButton: true),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _onExistingSDCard,
                  child: TrText('setup.btn.skip_to_next_step', isButton: true),
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
      MaterialPageRoute(builder: (ctx) => FlashSDCardPage()),
    );

    if (res != null && res is bool && res) {
      widget.onStepDone(0);
    }
  }

  void _onExistingSDCard() {
    // TODO: implement me
    final snackBar = SnackBar(content: Text('TODO :('));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
