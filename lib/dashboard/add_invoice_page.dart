import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:custom_keyboard/custom_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddInvoicePage extends StatefulWidget {
  const AddInvoicePage({Key? key}) : super(key: key);

  @override
  _AddInvoicePageState createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  final _amtController = TextEditingController();
  final _amtNode = FocusNode();
  final _memoController = TextEditingController();
  final _memoNode = FocusNode();
  bool _showKeyboard = true;

  late final AddInvoiceBloc _invoiceBloc;
  late final WatchInvoiceBloc _watchInvoiceBloc;
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

    _invoiceBloc = AddInvoiceBloc(RepositoryProvider.of(context));
    _watchInvoiceBloc = WatchInvoiceBloc(RepositoryProvider.of(context));
  }

  @override
  void dispose() {
    super.dispose();
    _amtController.dispose();
    _amtNode.dispose();
    _memoController.dispose();
    _memoNode.dispose();
    _watchInvoiceBloc.add(CancelAll());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildHeaderBar(theme),
      body: BlocBuilder<AddInvoiceBloc, AddInvoiceBaseState>(
        bloc: _invoiceBloc,
        builder: (context, state) {
          if (state is AddInvoiceInitial) {
            return _buildGetDataWidget();
          } else if (state is InvoiceAddedState) {
            _watchInvoiceBloc.add(WatchInvoice(state.payReq));
            return _buildQR(state.payReq);
          } else if (state is AddInvoiceErrorState) {
            return Center(child: Text('Error state ${state.errorMessage}.'));
          } else {
            return Center(child: Text('Unknown state $state'));
          }
        },
      ),
    );
  }

  Widget _buildQR(String payReq) {
    return BlocBuilder<WatchInvoiceBloc, WatchInvoiceBaseState>(
      bloc: _watchInvoiceBloc,
      builder: (context, state) {
        if (state is InvoiceUpdateState &&
            state.invoice.state == InvoiceState.settled) {
          // TODO: improve me
          return const Center(child: Text('Yay! Paid!!'));
        }
        return Center(
          child: QrImage(
            backgroundColor: Colors.grey[300]!,
            data: payReq,
            version: QrVersions.auto,
            size: 180.0,
          ),
        );
      },
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
                  final amt = int.tryParse(_amtController.text);
                  if (amt == null) {
                    final snackBar =
                        SnackBar(content: Text('Amount $amt invalid'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }
                  final memo = _memoController.text;
                  _invoiceBloc.add(AddInvoiceEvent(amt, memo));
                },
                child: const TrText('wallet.lightning.get_invoice'),
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
          BlitzLog().w('Receiving input but no text field is active');
        }
      },
      onBackspace: () {
        final ctrl = _getCurrentController();
        if (ctrl != null) {
          handleBackspace(ctrl);
        } else {
          BlitzLog().w('Receiving input but no text field is active');
        }
      },
      onEnter: () {
        if (_amtNode.hasFocus) {
          _amtNode.nextFocus();
        } else if (_memoNode.hasFocus) {
          _memoNode.unfocus();
          // _memoNode.unfocus() triggers the listener on the node
          // which will set _showKeyboard  to true again
          // => set _showKeyboard to false slightly delayed
          _clearKeyboard();
        }
      },
    );
  }

  PreferredSize _buildHeaderBar(ThemeData theme) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0), // here the desired height
      child: Material(
        elevation: 3.0,
        child: Container(
          color: Colors.transparent,
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 8.0),
              SizedBox(
                height: 20,
                child: Image.asset('assets/RaspiBlitz_Logo_Icon_Negative.png'),
              ),
              const SizedBox(width: 8),
              TrText(
                'wallet.lightning.add_invoice',
                style: theme.textTheme.headline5!,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clearKeyboard() async {
    await Future.delayed(const Duration(milliseconds: 10));
    setState(() {
      _showKeyboard = false;
    });
  }

  TextEditingController? _getCurrentController() {
    if (_amtNode.hasFocus) {
      return _amtController;
    } else if (_memoNode.hasFocus) {
      return _memoController;
    }

    return null;
  }
}
