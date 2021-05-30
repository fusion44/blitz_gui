import 'package:flutter/material.dart';

import '../common/widgets/keyboard/custom_keyboard.dart';

class AddInvoicePage extends StatefulWidget {
  @override
  _AddInvoicePageState createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  final _amtController = TextEditingController();
  final _amtNode = FocusNode();
  final _memoController = TextEditingController();
  final _memoNode = FocusNode();
  bool _showKeyboard = true;

  @override
  void initState() {
    super.initState();
    _amtNode.addListener(() {
      if (!_amtNode.hasFocus) {
        setState(() {
          _showKeyboard = true;
        });
      }
    });
    _memoNode.addListener(() {
      if (!_memoNode.hasFocus) {
        setState(() {
          _showKeyboard = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _amtController.dispose();
    _amtNode.dispose();
    _memoController.dispose();
    _memoNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildHeaderBar(theme),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autofocus: true,
                controller: _amtController,
                focusNode: _amtNode,
                decoration: InputDecoration(hintText: 'Amount'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: TextField(
                controller: _memoController,
                focusNode: _memoNode,
                decoration: InputDecoration(hintText: 'Memo'),
              ),
            ),
            if (_showKeyboard)
              CustomKeyboard(
                onTextInput: (input) {
                  if (_amtNode.hasFocus) {
                    _amtController.text = _amtController.text + input;
                  } else if (_memoNode.hasFocus) {
                    _memoController.text = _memoController.text + input;
                  }
                },
                onBackspace: () {},
                onEnter: () {
                  if (_amtNode.hasFocus) {
                    _amtNode.nextFocus();
                  } else if (_memoNode.hasFocus) {
                    _memoNode.unfocus();
                    // _memoNode.unfocus() triggers the listener on the node
                    // which will set _showKeyboard  to true again
                    // => set _showKeybaord to false slightly delayed
                    _clearKeyboard();
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildHeaderBar(ThemeData theme) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0), // here the desired height
      child: Material(
        elevation: 3.0,
        child: Container(
          color: Colors.transparent,
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 8.0),
              Container(
                height: 20,
                child: Image.asset('assets/RaspiBlitz_Logo_Icon_Negative.png'),
              ),
              SizedBox(width: 8),
              Text(
                'Add Invoice',
                style: theme.textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clearKeyboard() async {
    await Future.delayed(Duration(milliseconds: 10));
    setState(() {
      _showKeyboard = false;
    });
  }
}
