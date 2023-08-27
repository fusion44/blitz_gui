import 'dart:async';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:ndialog/ndialog.dart';
import 'package:regtest_core/core.dart';

import '../../gui_constants.dart';
import '../../widgets/mine_blocks_dlg_content.dart';
import '../../widgets/tools_columns.dart';
import '../../widgets/widget_utils.dart';
import '../containers/redis_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final notificationPlugin = FlutterLocalNotificationsPlugin();

  bool _miningBlocks = false;
  int _numBlocks = 0;
  int _currentBlock = 0;

  String _notification = "";

  NetworkStateMessage _networkState = NetworkStateMessage.checking();
  late final NetworkManager _mgr;

  StreamSubscription<NetworkStateMessage>? _sub;

  @override
  void initState() {
    super.initState();
    _initNetwork();
  }

  void _initNetwork() async {
    _mgr = NetworkManager();

    try {
      if (!_mgr.initialized) await _mgr.init();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    _sub = _mgr.netStateStream.listen(
        (event) => mounted ? setState(() => _networkState = event) : null);
    _mgr.refresh();

    RedisManager().init();
  }

  @override
  void dispose() async {
    super.dispose();
    if (_sub != null) await _sub!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Machine Room"),
        actions: [
          if (_networkState.state == NetworkState.up)
            Tooltip(
              message: "Apply Network",
              child: IconButton(
                icon: const Icon(Icons.auto_graph, color: Colors.blue),
                onPressed: () => _mgr.applyNetwork(),
              ),
            ),
          _buildRunningActionBtn()
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            elevation: 5,
            selectedIndex: 0,
            onDestinationSelected: (int index) =>
                context.goNamed(RouteNames.values[index].name),
            labelType: NavigationRailLabelType.all,
            destinations: getNavRailDestinations(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _mgr.fundNodes(),
                        child: const Text("Fund Nodes"),
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () => _mineBlocks(context),
                        child: const Text("Mine Blocks"),
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton.icon(
                        onPressed: () => _payFromClipboard(),
                        icon: const Icon(Icons.bolt),
                        label: const Text("Pay Clipboard"),
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton.icon(
                        onPressed: () => _payFromClipboardGetDelay(context),
                        icon: const Icon(Icons.hourglass_bottom_rounded),
                        label: const Text("Pay Clipboard"),
                      ),
                    ],
                  ),
                  if (_miningBlocks)
                    Text('Mining blocks (${_currentBlock + 1} / $_numBlocks)'),
                  if (_notification.isNotEmpty)
                    Text(
                      _notification,
                      style: theme.textTheme.headlineSmall,
                    ),
                  const Divider(),
                  _buildMainContent(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRunningActionBtn() {
    if (_networkState.state == NetworkState.checking) {
      return const Tooltip(
        message: "Checking status of containers",
        child: SpinKitFadingCube(
          size: headerBarIconSize,
          color: Colors.amberAccent,
        ),
      );
    }

    if (_networkState.state == NetworkState.up) {
      return Tooltip(
        message: "Stop containers",
        child: IconButton(
          icon: const Icon(Icons.arrow_downward, color: Colors.red),
          onPressed: () => _mgr.stop(),
        ),
      );
    }

    if (_networkState.state == NetworkState.startingUp) {
      return const Tooltip(
        message: "Starting containers",
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SpinKitFadingCube(
              size: headerBarIconSize, color: Colors.greenAccent),
        ),
      );
    }

    if (_networkState.state == NetworkState.shuttingDown) {
      return const Tooltip(
        message: "Shutting down containers",
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SpinKitFadingCube(
            size: headerBarIconSize,
            color: Colors.redAccent,
          ),
        ),
      );
    }

    if (_networkState.state == NetworkState.down) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _mgr.start(exposeDataDirToHost: true),
          child: const Text("Start"),
        ),
      );
    }

    if (_networkState.state == NetworkState.error) {
      return Tooltip(
        message: "Click to recreate containers",
        child: IconButton(
          icon: const Icon(Icons.error, color: Colors.red),
          onPressed: () => _mgr.recreate(),
        ),
      );
    }

    if (_networkState.state == NetworkState.cleanup) {
      return const Tooltip(
        message: "Removing all containers",
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SpinKitFadingCube(
            size: headerBarIconSize,
            color: Colors.redAccent,
          ),
        ),
      );
    }

    return Tooltip(
      message: "You should not see this. Invalid state: $_networkState",
      child: IconButton(
        icon: const Icon(Icons.question_mark),
        color: Colors.red,
        onPressed: () => _mgr.refresh(),
      ),
    );
  }

  void _mineBlocks(BuildContext c) async {
    final ValueNotifier<MineBlockData> blockData =
        ValueNotifier<MineBlockData>(MineBlockData.empty());

    final res = await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const Text("Mine Blocks"),
      content: MineBlocksDlgContent(blockData),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () => Navigator.pop(c, "OK"),
        ),
      ],
    ).show(context);

    if (res == null || res != "OK") return;

    var from = blockData.value.from;
    var to = blockData.value.to;

    if (to < from) {
      to = blockData.value.from;
      from = blockData.value.to;
    }

    setState(() {
      _miningBlocks = true;
      _numBlocks = blockData.value.numBlocks;
      _currentBlock = 0;
    });

    final btcc = _mgr.findFirstOf<BitcoinCoreContainer>();
    if (btcc == null) {
      throw StateError('BitcoinCoreContainer not found');
    }

    if (blockData.value.delay) {
      while (_currentBlock < blockData.value.numBlocks) {
        final delay = from != to ? Random().nextInt(to) + from : from;
        await Future.delayed(Duration(seconds: delay));
        await btcc.mineBlocks(1);
        setState(() => _currentBlock += 1);
      }

      debugPrint('Done mining');
    } else {
      await btcc.mineBlocks(blockData.value.numBlocks);
    }

    setState(() => _miningBlocks = false);
  }

  _payFromClipboardGetDelay(BuildContext c) async {
    final ctrl = TextEditingController(text: "5");

    var res = await buildGetTimeInSecondsDlg(
      c,
      ctrl,
      "Get Delay Time",
      "delay in seconds",
    ).show(context);

    if (res != "OK" || !mounted) return;

    final delay = int.tryParse(ctrl.text);
    if (delay == null) {
      buildSnackbar(c, msg: "unable to parse delay");
      return;
    }

    res = await _payFromClipboard(delay);
    if (res == null) {
      // _payFromClipboard will show an error message
      return;
    }

    await notificationPlugin.show(0, 'Paid Invoice', res, null);
  }

  _payFromClipboard([int delay = 0]) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;

    if (!mounted) return;

    if (text == null || text.isEmpty || !text.startsWith("lnbcrt")) {
      buildSnackbar(context, msg: "Unable to find a valid invoice.");
      return;
    }

    try {
      if (delay > 0) {
        await _delayWithNotification(delay, "pay invoice");
      }

      setState(() => _notification = "Attempting send payment");
      final randNode = getRandNode();
      final res = await randNode.payInvoice(PayInvoiceData(
        text,
      ));

      if (!mounted) return;

      if (res) {
        buildSnackbar(
          context,
          title: "Nice!",
          msg: "Invoice paid successfully",
          ct: ContentType.success,
        );
      }
      setState(() => _notification = "");
    } catch (e) {
      logMessage(e.toString());
    }
  }

  Future<void> _delayWithNotification(int delay, String message) async {
    for (var i = 0; i < delay; i++) {
      setState(() =>
          _notification = "task $message scheduled in ${delay - i} seconds");
      await Future.delayed(const Duration(seconds: 1));
    }

    setState(() => _notification = "");
  }

  void _setNotificationCallback([String message = ""]) =>
      setState(() => _notification = message);

  Widget _buildMainContent() {
    if (_networkState.state == NetworkState.up) {
      if (NetworkManager().lnNodes.isEmpty) {
        return const Center(child: Text("Error: No nodes found"));
      }

      return Expanded(
        child: ToolsColumns(_setNotificationCallback, NetworkManager().lnNodes),
      );
    }

    if (_networkState.state == NetworkState.error) {
      return Center(child: Text("Error:\n${_networkState.message.toString()}"));
    }

    return Center(child: Text("Network is ${_networkState.state.toString()}"));
  }
}
