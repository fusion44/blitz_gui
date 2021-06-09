import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/settings_bloc/settings_bloc.dart';
import '../common/widgets/money_value_view.dart';
import '../common/widgets/time_ago.dart';

class FundsPage extends StatefulWidget {
  final Function(bool) _setFABVisible;

  FundsPage(this._setFABVisible);

  @override
  _FundsPageState createState() => _FundsPageState();
}

class _FundsPageState extends State<FundsPage> {
  ScrollController _hideFABController;
  var _fabVisible;

  @override
  void initState() {
    super.initState();
    _fabVisible = true;
    _hideFABController = ScrollController();
    _hideFABController.addListener(() {
      if (_hideFABController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_fabVisible == true) {
          _fabVisible = false;
          widget._setFABVisible(_fabVisible);
        }
      } else {
        if (_hideFABController.position.userScrollDirection ==
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
    _hideFABController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SettingsBloc, SettingsBaseState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0),
          child: ListView(
            controller: _hideFABController,
            children: [
              _buildFundsRow(state, 2503519, 29193727, theme),
              Divider(),
              ..._buildList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFundsRow(
    SettingsBaseState state,
    int onchain,
    int ln,
    ThemeData theme,
  ) {
    final f = NumberFormat.currency(
      locale: state.langCode,
      name: '',
      decimalDigits: 0,
    );

    final left = state.currSymbolIsLeft;
    final color = state.darkTheme ? Colors.white : Colors.black;

    return Row(
      children: [
        Image.asset('assets/icons/link.png', color: Colors.deepOrange[800]),
        if (!left) SizedBox(width: 8.0),
        if (left)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 4.0),
            child: Image.asset('assets/icons/satoshi-v2.png', color: color),
          ),
        Text(f.format(onchain), style: theme.textTheme.headline6),
        if (!left)
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Image.asset('assets/icons/satoshi-v2.png', color: color),
          ),
        Spacer(),
        Image.asset('assets/icons/lightning.png', color: Colors.yellow[800]),
        if (!left) SizedBox(width: 8.0),
        if (left)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 4.0),
            child: Image.asset('assets/icons/satoshi-v2.png', color: color),
          ),
        Text(f.format(ln), style: theme.textTheme.headline6),
        if (!left)
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Image.asset('assets/icons/satoshi-v2.png', color: color),
          ),
      ],
    );
  }

  Iterable<Widget> _buildList() {
    return [
      _buildListFakeTile1(),
      _buildListFakeTile2(),
      _buildListFakeTile3(),
      _buildListFakeTile3(),
      _buildListFakeTile3(),
      _buildListFakeTile3(),
      _buildListFakeTile3(),
      _buildListFakeTile3(),
      _buildListFakeTile3(),
      _buildListFakeTile3(),
    ];
  }

  Widget _buildListFakeTile1() {
    var theme = Theme.of(context);

    var textStyle = theme.textTheme.caption;

    final icon = Icon(Icons.arrow_forward, color: Colors.greenAccent);

    return ListTile(
      leading: icon,
      title: TimeAgoText(DateTime.now().subtract(Duration(days: 2)),
          allowFromNow: false),
      subtitle: Text(
        'Ebay - sold old phone',
        style: textStyle,
      ),
      trailing: MoneyValueView(
        amount: 42534,
        textAlign: TextAlign.end,
        settled: true,
        fee: 8,
      ),
      dense: true,
    );
  }

  Widget _buildListFakeTile2() {
    var theme = Theme.of(context);
    var textStyle = theme.textTheme.caption;
    final icon = Icon(Icons.arrow_back, color: Colors.redAccent);

    return ListTile(
      leading: icon,
      title: TimeAgoText(DateTime.now().subtract(Duration(days: 2)),
          allowFromNow: false),
      subtitle: Text(
        'Dinner at Wendies',
        style: textStyle,
      ),
      trailing: MoneyValueView(
        amount: 42534,
        textAlign: TextAlign.end,
        settled: true,
        fee: 8,
      ),
      dense: true,
    );
  }

  Widget _buildListFakeTile3() {
    var theme = Theme.of(context);
    var textStyle = theme.textTheme.caption;
    final icon = Icon(Icons.arrow_back, color: Colors.redAccent);

    return ListTile(
      leading: icon,
      title: TimeAgoText(DateTime.now().subtract(Duration(days: 2)),
          allowFromNow: false),
      subtitle: Text(
        '8 confirmations',
        style: textStyle,
      ),
      trailing: MoneyValueView(
        amount: 1342534,
        textAlign: TextAlign.end,
        settled: true,
        fee: 8,
      ),
      dense: true,
    );
  }
}
