import 'dart:io';

import 'package:common/common.dart';

class PortManager {
  // Singleton stuff
  static final PortManager _instance = PortManager._internal();
  factory PortManager() => _instance;
  PortManager._internal();

  // PortManager
  Set<int> openedPorts = {};

  Future<int> nextUnusedPort(ValueRange portRange) async {
    for (var port = portRange.start; port <= portRange.end; port++) {
      if (!openedPorts.contains(port)) {
        if (await _isPortFree(port)) {
          openedPorts.add(port);
          return port;
        }
      }
    }

    throw Exception('No more free ports are available in this range');
  }

  Future<int> setPortUsed(int port) async {
    if (await _isPortFree(port)) {
      openedPorts.add(port);
      return port;
    }

    throw Exception('The port $port is already used');
  }

  void clearPort(int port) {
    openedPorts.remove(port);
  }

  void clearPorts(List<int> ports) {
    for (final p in ports) {
      openedPorts.remove(p);
    }
  }

  Future<bool> _isPortFree(int port) async {
    try {
      var server = await ServerSocket.bind(InternetAddress.loopbackIPv4, port);
      await server.close();
      return true;
    } catch (e) {
      return false;
    }
  }
}
