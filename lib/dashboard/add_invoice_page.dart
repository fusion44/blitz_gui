import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../common/utils.dart';
import '../common/widgets/keyboard/keyboard.dart';
import '../common/widgets/translated_text.dart';

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
  bool _showQR = false;
  String _qrData = '';

  @override
  void initState() {
    super.initState();
    _amtNode.addListener(() {
      if (_amtNode.hasFocus) {
        setState(() {
          _showKeyboard = true;
        });
      }
    });
    _memoNode.addListener(() {
      if (_memoNode.hasFocus) {
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
      body: _showQR ? _buildQR() : _buildGetDataWidget(),
    );
  }

  Widget _buildQR() {
    return Center(
      child: QrImage(
        backgroundColor: Colors.grey[300],
        data: _qrData,
        version: QrVersions.auto,
        size: 180.0,
      ),
    );
  }

  Widget _buildGetDataWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              controller: _amtController,
              focusNode: _amtNode,
              decoration: InputDecoration(
                hintText: tr('wallet.new_invoice_amount'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextField(
              controller: _memoController,
              focusNode: _memoNode,
              decoration: InputDecoration(
                hintText: tr('wallet.lightning.memo'),
              ),
            ),
          ),
          if (_showKeyboard) _buildCustomKeyboard(),
          if (!_showKeyboard && _amtController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showQR = true;
                    _qrData =
                        'lnbc1u1pstve8wpp50u23d4zl7h73mlus8wgwv8p76dxvzkawfgjzx8xwadyynmphy2cqdq52fshxurfvfkxjar69v4scqzpgxq9pyagqsp5xxlrxj74y8e2ydn0e77n6p5syf82u4k9tnaawydkpn6htpf4knds9qyyssqhctd6plty5j5f2g9zfrehpa4flvjk9r4wc452laqr3ng89xf9ucq35t58d034tl7qpuxcxglf7vu262mlwjshw938ajvta2qv4z44wcqjm98ha';
                  });
                },
                child: TrText('wallet.lightning.get_invoice'),
              ),
            )
        ],
      ),
    );
  }

  CustomKeyboard _buildCustomKeyboard() {
    return CustomKeyboard(
      onTextInput: (input) {
        final ctrl = _getCurrentController();
        if (ctrl != null) {
          handleInsertText(ctrl, input);
        } else {
          print(
            'Warning: Receiving input but no text field is active',
          );
        }
      },
      onBackspace: () {
        final ctrl = _getCurrentController();
        if (ctrl != null) {
          handleBackspace(ctrl);
        } else {
          print(
            'Warning: Receiving input but no text field is active',
          );
        }
      },
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
              TrText(
                'wallet.lightning.add_invoice',
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

  TextEditingController _getCurrentController() {
    if (_amtNode.hasFocus) {
      return _amtController;
    } else if (_memoNode.hasFocus) {
      return _memoController;
    }

    return null;
  }
}
