import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../common/subscription_repository.dart';
import 'blocs/system_info/system_info_bloc.dart';
import 'blocs/system_info/system_info_widget.dart';
import 'text_fragment.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final double spacing = 4.0;

  late SystemInfoBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = SystemInfoBloc(
      RepositoryProvider.of<SubscriptionRepository>(context),
    );
    _bloc.add(StartListenSystemInfo());
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.add(StopListenSystemInfo());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            SizedBox(height: spacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Raspiblitz v1.7'),
                Text(
                  'RecklessBlitz',
                  style: theme.textTheme.bodyText1!.copyWith(
                    color: Colors.green[600],
                  ),
                )
              ],
            ),
            SizedBox(height: spacing),
            Text('Bitcoin Fullnode + Lightning Network + TOR'),
            Divider(),
            SizedBox(height: spacing),
            BlocBuilder<SystemInfoBloc, SystemInfoBaseState>(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is SystemInfoState) {
                    return SystemInfoWidget(
                      state.info,
                      state.downloadRate,
                      state.uploadRate,
                    );
                  } else {
                    return Center(child: SpinKitChasingDots(color: Colors.red));
                  }
                }),
            Divider(),
            _buildRow(
              [
                _buildTextFragment('Bitcoin ', theme),
                _buildTextFragment('v0.21.1', theme, Colors.green),
              ],
              [
                _buildTextFragment('Sync: ', theme),
                _buildTextFragment('OK 100.0%', theme, Colors.green),
              ],
            ),
            _buildRow(
              [
                _buildTextFragment('Public ', theme),
                _buildTextFragment(
                  '91.64.156.143:8333',
                  theme,
                  Colors.red[400],
                ),
              ],
              [
                _buildTextFragment('11 ', theme, Colors.purple[200]),
                _buildTextFragment('connections', theme),
              ],
            ),
            Divider(),
            _buildRow(
              [
                _buildTextFragment('LND ', theme),
                _buildTextFragment('v0.12.0-beta', theme, Colors.green),
              ],
              [
                _buildTextFragment('wallet ', theme),
                _buildTextFragment('68892 sat', theme, Colors.orange),
              ],
            ),
            _buildRow(
              [
                _buildTextFragment('4/0 Channels with ', theme),
                _buildTextFragment('1140252 sat', theme, Colors.orange),
              ],
              [
                _buildTextFragment('6 ', theme, Colors.purple[200]),
                _buildTextFragment('peers', theme),
              ],
            ),
            _buildRow(
              [
                _buildTextFragment('Fee Report in sat: ', theme),
                _buildTextFragment('11-124-497', theme, Colors.orange),
                _buildTextFragment(' (Day-Week-Month)', theme),
              ],
              [],
            ),
          ],
        ),
      ),
    );
  }

  TextFragment _buildTextFragment(String text, ThemeData theme,
      [Color? color]) {
    return TextFragment(
      text,
      color == null
          ? theme.textTheme.bodyText1!
          : theme.textTheme.bodyText1!.copyWith(color: color),
    );
  }

  Widget _buildRow(List<TextFragment> left, List<TextFragment> right) {
    return Row(
      children: [
        for (var i in left) i.toTextWidget(),
        Spacer(),
        for (var i in right) i.toTextWidget(),
      ],
    );
  }
}
