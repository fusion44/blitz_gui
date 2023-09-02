import 'package:graph_network_canvas/graph_network_canvas.dart';
import 'package:regtest_core/core.dart';
/*
Note: This is not included in the NetworkManager class because we
want to avoid a dependency to the gnc library there.
*/

/// A class which tracks connections between nodes and processes
/// the data so it can be used by the graph_network_canvas library

class ConnectionManager {
  // Singleton stuff
  static final ConnectionManager _instance = ConnectionManager._internal();
  factory ConnectionManager() => _instance;

  ConnectionManager._internal();

  final List<ConnectionData> _connections = [];

  /// Get all known connections
  List<ConnectionData> get connections => _connections;

  /// Updates the connections
  Future<void> update() async {
    _connections.clear();
    final mgr = NetworkManager();

    final lnNodes = mgr.findAllOf<LnContainer>();
    final btcc = mgr.findFirstOf<BitcoinCoreContainer>();
    if (btcc != null) {
      for (final n in lnNodes) {
        _connections.add(ConnectionData(n.internalId, btcc.internalId));
      }
    }
  }
}
