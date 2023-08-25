import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:regtest_core/core.dart';
import 'package:blitz_api_client/blitz_api_client.dart';

part 'blitz_api_container_event.dart';
part 'blitz_api_container_state.dart';

class BlitzApiContainerBloc
    extends Bloc<BlitzApiContainerEvent, BlitzApiContainerState> {
  final String containerId;
  final String myId;
  BlitzApiClient? _client;
  final bool bitcoinOnly;
  StreamSubscription<ContainerStatusMessage>? _sub;
  String _token = '';

  BlitzApiContainerBloc(this.containerId, this.myId, {this.bitcoinOnly = false})
      : super(BlitzApiStatusUpdate.fromContainer(myId)) {
    if (NetworkManager().findContainerById(myId) == null) {
      throw StateError('BlitzApiContainer with ID $myId not found');
    }

    if (NetworkManager().findContainerById(myId)!.running) {
      _prepareAPI();
    }

    on<BlitzApiSettingsUpdatedEvent>(_handleSettingsUpdatedEvent);
    on<StartBlitzApiContainerEvent>(_handleStartEvent);
    on<StopBlitzApiContainerEvent>(
        (_, __) async => await NetworkManager().stopContainer(myId));
    on<DeleteBlitzApiContainerEvent>(
        (_, __) async => await NetworkManager().deleteContainer(myId));
    on<_BlitzApiStatusUpdate>(_handleApiStatusUpdateEvent);
    on<BlitzApiOpenChannelEvent>(_handleOpenChannelEvent);

    _subStatuses();
  }

  @override
  Future<void> close() async {
    await _unSubStatuses();
    _client?.dio.close();
    super.close();
  }

  Future<void> _subStatuses() async {
    _sub?.cancel();

    final c = NetworkManager().findContainerById<BlitzApiContainer>(myId);

    if (c == null) {
      throw StateError('BlitzApiContainer with ID $myId not found');
    }

    _sub = c.statusStream.listen((event) {
      add(_BlitzApiStatusUpdate(event));
    });

    try {
      final event = await c.statusStream.last;
      add(_BlitzApiStatusUpdate(event));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _unSubStatuses() async {
    await _sub?.cancel();
    _sub = null;
  }

  Future<void> _prepareAPI() async {
    final c = NetworkManager().findContainerById(myId);
    if (c == null || c is! BlitzApiContainer) {
      throw StateError('BlitzApiContainer with ID $myId not found');
    }

    final url = 'http://localhost:${c.restPort}/latest';
    final client = BlitzApiClient(basePathOverride: url);
    _client = client;
    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) {
          if (_token.isNotEmpty) {
            options.headers["AUTHORIZATION"] = _token;
          }
          handler.next(options);
        },
      ),
    );

    final systemApi = client.getSystemApi();
    final builder = LoginInputBuilder()..password = "12345678";

    DioError? lastError;
    bool success = false;
    for (var i = 0; i < 5; i++) {
      try {
        final response = await systemApi.systemLoginSystemLoginPost(
          loginInput: builder.build(),
        );

        final data = response.data;
        if (data == null || data.value is! String) {
          throw StateError("Login response data was null");
        }

        _token = "Bearer ${data.value.toString()}";

        if (bitcoinOnly) {
          return;
        }

        final lnInfoResp = await client
            .getLightningApi()
            .lightningGetInfoLightningGetInfoGet();

        if (lnInfoResp.statusCode != 200) {
          throw Exception("Failed to bootstrap API node $myId");
        }

        success = true;
        break;
      } on DioError catch (e) {
        // Maybe the API isn't yet ready. Wait for a second...
        await Future.delayed(Duration(seconds: 1));
        lastError = e;
        print('Waiting for API ...');
      }
    }

    if (!success && lastError != null) {
      print('Unable to login to Blitz API. Error: ${lastError.message}');
    } else if (!success && lastError == null) {
      print('Unable to login to Blitz API. Unknown error');
    }
  }

  FutureOr<void> _handleSettingsUpdatedEvent(
    BlitzApiSettingsUpdatedEvent event,
    Emitter<BlitzApiContainerState> emit,
  ) async {
    // NetworkManager internally creates a new Container, so we have
    // to resubscribe to get status information from the new container
    await _unSubStatuses();
    await NetworkManager().updateContainerOptions(myId, event.options);
    await _subStatuses();

    emit(
      BlitzApiStatusUpdate(
        ContainerStatusMessage(
          ContainerStatus.uninitialized,
          'Settings updated.',
        ),
        event.options.name,
        event.options.image,
        event.options.workDir,
      ),
    );
  }

  FutureOr<void> _handleStartEvent(
    StartBlitzApiContainerEvent event,
    Emitter<BlitzApiContainerState> emit,
  ) async {
    _subStatuses();
    await NetworkManager().startContainer(myId);
    await _prepareAPI();
  }

  FutureOr<void> _handleApiStatusUpdateEvent(
    _BlitzApiStatusUpdate event,
    Emitter<BlitzApiContainerState> emit,
  ) async {
    if (event.status.status == ContainerStatus.deleted) {
      final lastState = state;
      if (lastState is BlitzApiStatusUpdate) {
        emit(
          BlitzApiStatusUpdate(
            event.status,
            lastState.name,
            lastState.image,
            lastState.workDir,
          ),
        );
      }

      await _unSubStatuses();
      return;
    }

    final c = NetworkManager().nodeMap[myId] as BlitzApiContainer;
    emit(
      BlitzApiStatusUpdate(
        event.status,
        c.containerName,
        c.image,
        c.workDir,
      ),
    );
  }

  FutureOr<void> _handleOpenChannelEvent(
    BlitzApiOpenChannelEvent event,
    Emitter<BlitzApiContainerState> emit,
  ) async {
    if (_client == null) throw StateError('Blitz API client object is null');

    final to = NetworkManager().findContainerById<LnNode>(
      event.targetContainerId,
    );

    if (to == null) {
      print('Unable to find target node with id ${event.targetContainerId}');
      return;
    }

    try {
      final res = await _client!
          .getLightningApi()
          .lightningOpenChannelLightningOpenChannelPost(
            localFundingAmount: event.localFundingAmount,
            nodeURI: to.fullUri,
            pushAmountSat: event.pushAmountSat,
          );

      print(res.data);
    } catch (e) {
      print(e);
    }
  }
}
