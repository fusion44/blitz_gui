import 'dart:async';
import 'dart:convert';

import 'package:blitz_api_client/blitz_api_client.dart' as c;
import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:go_router/go_router.dart';
import 'package:ndialog/ndialog.dart';
import 'package:regtest_core/core.dart';
import 'package:subscription_repository/subscription_repository.dart';

import '../../gui_constants.dart';
import 'sse_event_filter_dlg_contents.dart';

class _SSEEvent {
  final DateTime receivedAt;
  final SseEventTypes type;
  final dynamic data;
  final String rawType;

  _SSEEvent(this.receivedAt, this.type, this.data, {this.rawType = ''});

  @override
  String toString() => '$receivedAt $type';
}

class SSEInspectorPage extends StatefulWidget {
  final String _url;
  final String _password;

  const SSEInspectorPage(this._url, this._password, {super.key});

  @override
  State<SSEInspectorPage> createState() => _SSEInspectorPageState();
}

class _SSEInspectorPageState extends State<SSEInspectorPage> {
  String _token = '';
  final _repo = SubscriptionRepository.instance();

  // all events, unfiltered
  final _eventList = <_SSEEvent>[];

  // the event as filtered by the filter
  final _filtered = <_SSEEvent>[];

  // the filter
  final _filter = <SseEventTypes>[
    SseEventTypes.btcInfo,
    SseEventTypes.hardwareInfo
  ];

  bool _initialized = false;
  late final c.BlitzApiClient _api;
  String _error = '';

  StreamSubscription? _sub;

  c.LnInfo? _lnInfo;
  c.SystemInfo? _sysInfo;

  String _json = '{}';
  String _text = '';

  @override
  void initState() {
    super.initState();

    initApi();
  }

  Future<void> initApi() async {
    final bo = BaseOptions(
      baseUrl: '${widget._url}/latest',
      connectTimeout: 5000,
      receiveTimeout: 30000,
    );

    _api = c.BlitzApiClient(dio: Dio(bo));
    _api.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) {
          if (_token.isNotEmpty) {
            options.headers["AUTHORIZATION"] = _token;
          }
          handler.next(options);
        },
      ),
    );

    final api = _api.getSystemApi();
    final builder = c.LoginInputBuilder()..password = widget._password;

    try {
      final response = await api.systemLoginSystemLoginPost(
        loginInput: builder.build(),
      );

      final data = response.data;
      if (data == null || data.value is! String) {
        throw StateError("Login response data was null");
      }

      _token = "Bearer ${data.value.toString()}";
    } on DioError catch (e) {
      printDioError(
        e,
        '${widget._url}: Exception when calling SystemApi->systemLoginSystemLoginPost',
      );

      setState(() {
        _initialized = true;
        _error = '${e.message}: ${e.response?.data['detail']}';
      });

      return;
    }

    final resp =
        await _api.getLightningApi().lightningGetInfoLightningGetInfoGet();
    if (resp.statusCode != 200) {
      setState(() {
        _initialized = true;
        _error = '${resp.statusMessage}: ${resp.data}';
      });

      return;
    }

    _lnInfo = resp.data;

    final resp2 =
        await _api.getSystemApi().systemGetSystemInfoSystemGetSystemInfoGet();
    if (resp2.statusCode != 200) {
      setState(() {
        _initialized = true;
        _error = '${resp2.statusMessage}: ${resp2.data}';
      });

      return;
    }

    _sysInfo = resp2.data;

    await initRepo();
  }

  Future<void> initRepo() async {
    if (_repo.initialized) return;

    if (_token.isEmpty) {
      throw StateError("Token is not properly set");
    }

    await _repo.init(widget._url, _token);

    final stream = _repo.filteredStream([]);
    if (stream != null) {
      _sub = stream.listen(
        (event) => setState(() {
          final e = _SSEEvent(
            DateTime.now(),
            event['id'],
            event['data'],
            rawType: event['event'],
          );
          _eventList.insert(0, e);
          if (_filter.isNotEmpty) _updateFilter();
        }),
      );
    } else {
      BlitzLog().w('Unable to connect to the SEE endpoint: ${widget._url}');
    }

    setState(() => _initialized = true);
  }

  @override
  void dispose() async {
    await _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool hasFilter = _filter.isNotEmpty;
    final evtList = hasFilter ? _filtered : _eventList;
    final evtListLength = evtList.length;

    Widget body;
    if (!_initialized) {
      body = const CircularProgressIndicator();
    } else if (_initialized && _error.isNotEmpty) {
      body = Center(child: Text(_error));
    } else {
      body = Row(
        children: [
          SizedBox(
            width: 250,
            child: ListView.separated(
              itemCount: hasFilter ? _filtered.length : _eventList.length,
              itemBuilder: (context, index) {
                if (evtList.isEmpty) return const SizedBox();
                final name = evtList[index].type != SseEventTypes.unknown
                    ? evtList[index].type.name
                    : "${evtList[index].type.name} (${evtList[index].rawType})";

                return ListTile(
                  title: Text("${evtListLength - index}: $name"),
                  dense: true,
                  subtitle: Text(evtList[index].receivedAt.toString()),
                  onTap: () => _eventSelected(
                    evtList[index],
                    evtListLength - index,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Text(_text, style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    child: HighlightView(
                      _json,
                      language: 'json',
                      theme: githubTheme,
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('SSE Inspector'),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget._url,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.secondaryContainer,
                  ),
                ),
                Text(
                  _lnInfo?.alias ?? '',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.secondaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _lnInfo?.implementation ?? '',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.secondaryContainer,
                  ),
                ),
                Text(
                  _lnInfo?.version ?? '',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.secondaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _sysInfo?.platform.toString() ?? '',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.secondaryContainer,
                  ),
                ),
                Text(
                  _sysInfo?.platformVersion ?? '',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.secondaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _sysInfo?.color ?? '',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.secondaryContainer,
                  ),
                ),
                Text(
                  _sysInfo?.apiVersion ?? '',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.secondaryContainer,
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          Tooltip(
            message:
                _filter.isEmpty ? 'No filter is applied' : 'Filter is applied',
            child: IconButton(
              icon: _filter.isEmpty
                  ? const Icon(Icons.filter_alt_off)
                  : const Icon(Icons.filter_alt,
                      color: Colors.deepOrangeAccent),
              onPressed: () => _openFilterDialog(context),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            elevation: 5,
            selectedIndex: 1,
            onDestinationSelected: (int index) =>
                context.goNamed(RouteNames.values[index].name),
            labelType: NavigationRailLabelType.all,
            destinations: getNavRailDestinations(),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }

  void _openFilterDialog(BuildContext c) async {
    final ValueNotifier<List<SseEventTypes>> newFilter =
        ValueNotifier<List<SseEventTypes>>(_filter);

    final res = await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const Text("Filter"),
      content: EventFilterDlgContent(newFilter),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () => Navigator.pop(c, "OK"),
        ),
      ],
    ).show(context);

    if (res == null || res != "OK") return;

    _filter.clear();
    _filter.addAll(newFilter.value);
    _updateFilter();
  }

  void _updateFilter() {
    setState(() {
      _filtered.clear();
      _filtered.addAll(_eventList.where((e) => !_filter.contains(e.type)));
    });
  }

  _eventSelected(_SSEEvent l, int index) {
    if (l.data is! Map && l.data is! List) {
      setState(() {
        _json = l.data.toString();
      });

      return;
    }

    const encoder = JsonEncoder.withIndent('  ');
    setState(() {
      _json = encoder.convert(l.data);
      _text = '$index: ${l.type.name} (${l.rawType})';
    });
  }
}
