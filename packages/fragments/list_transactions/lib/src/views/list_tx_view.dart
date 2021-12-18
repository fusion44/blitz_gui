import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/list_tx_bloc.dart';
import '../widgets/tx_list_item.dart';

class FundsPage extends StatefulWidget {
  final Function(bool) _setFABVisible;

  const FundsPage(this._setFABVisible, {Key? key}) : super(key: key);

  @override
  _FundsPageState createState() => _FundsPageState();
}

class _FundsPageState extends State<FundsPage> {
  late ScrollController _scrollController;
  var _fabVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_fabVisible == true) {
          _fabVisible = false;
          widget._setFABVisible(_fabVisible);
        }
        if (_isBottom) {
          context.read<ListTxBloc>().add(LoadMoreTx());
        }
      } else {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_fabVisible == false) {
            _fabVisible = true;
            widget._setFABVisible(_fabVisible);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListTxBloc, ListTxState>(
      builder: (context, txState) {
        switch (txState.status) {
          case ListTxStatus.failure:
            return const Center(child: Text('Failed to fetch transactions'));
          case ListTxStatus.success:
            if (txState.txs.isEmpty) {
              return const Center(child: Text('no transactions'));
            }

            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(thickness: 1),
              itemBuilder: (BuildContext context, int i) {
                return i >= txState.txs.length
                    ? const BottomLoader()
                    : TxListItem(tx: txState.txs[i]);
              },
              itemCount: txState.hasReachedMax
                  ? txState.txs.length
                  : txState.txs.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
