import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lan_scanner/lan_scanner.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../../prepare_sd_card/models/blitz_network_device.dart';
import '../../prepare_sd_card/models/setup_status_response.dart';

part 'device_scanner_event.dart';
part 'device_scanner_state.dart';

class DeviceScannerBloc extends Bloc<DeviceScannerEvent, DeviceScannerState> {
  Timer? _timer;

  StreamSubscription<HostModel>? _sub;

  DeviceScannerBloc() : super(DeviceScannerInitial()) {
    // TODO: implement a pause event

    on<DeviceScanStart>((event, emit) async {
      debugPrint('start');
      _scan();
    });

    on<_DeviceScanProgressUpdate>((event, emit) async {
      emit(event.state);
    });

    on<_DeviceScanError>((event, emit) async {
      emit(NetworkScanErrorState(event.message));
    });

    on<_DeviceScanFinished>((event, emit) async {
      emit(NetworkScanFinishedState(event.devices));
    });

    on<DeviceScanStop>((event, emit) async {
      _timer?.cancel();
      await _clearSubscription();
    });
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    _clearSubscription();
    return super.close();
  }

  Future<void> _scan() async {
    add(_DeviceScanProgressUpdate(const NetworkScanProgressState(0.0, [])));

    var wifiIP = await NetworkInfo().getWifiIP();
    if (wifiIP == null) {
      add(_DeviceScanError('Unable to query network'));
      return;
    }

    var subnet = ipToCSubnet(wifiIP);
    await _checkLocalhost();
    await _searchDevices(subnet);
  }

  Future<void> _searchDevices(String subnet) async {
    final scanner = LanScanner();
    final stream = scanner.icmpScan(
      subnet,
      scanThreads: 3,
      progressCallback: (progress) async {
        if (isClosed) {
          await _clearSubscription();
        }

        final s = state as NetworkScanProgressState;
        if (progress < 1) {
          add(_DeviceScanProgressUpdate(s.copyWith(progress: progress)));
        } else {
          add(_DeviceScanFinished([...s.devices]));
          await _clearSubscription();
        }
      },
    );

    await _clearSubscription();

    _sub = stream.listen((HostModel device) {
      _checkDevice(device);
    }, onDone: () {
      final devices = (state as NetworkScanProgressState).devices;
      add(_DeviceScanFinished([...devices]));
    }, onError: (e) {
      add(_DeviceScanError('Unable to query network'));
    });
  }

  Future<void> _checkDevice(HostModel device) async {
    if (!device.isReachable) return;

    try {
      final api = 'http://${device.ip}/api';
      var url = '$api/latest/setup/status';
      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        final setupState = SetupStatusResponse.fromJson(response.data);
        final localState = state as NetworkScanProgressState;
        final devices = (state as NetworkScanProgressState).devices;
        final bnd = BlitzNetworkDevice(api, true, setupState);
        add(_DeviceScanProgressUpdate(
          localState.copyWith(devices: [...devices, bnd]),
        ));
      }
    } on DioError catch (e) {
      debugPrint('Device not reachable: ${e.message}');
    }
  }

  Future<void> _clearSubscription() async {
    if (_sub != null) {
      await _sub?.cancel();
      _sub = null;
    }
  }

  Future<void> _checkLocalhost() async {
    try {
      const api = 'http://127.0.0.1:8000';
      var url = '$api/latest/setup/status';
      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        final setupState = SetupStatusResponse.fromJson(response.data);
        final localState = state as NetworkScanProgressState;
        final devices = (state as NetworkScanProgressState).devices;
        final bnd = BlitzNetworkDevice(api, true, setupState);
        add(_DeviceScanProgressUpdate(
          localState.copyWith(devices: [...devices, bnd]),
        ));
      }
    } on DioError catch (e) {
      debugPrint('Device not reachable: ${e.message}');
    }
  }
}
