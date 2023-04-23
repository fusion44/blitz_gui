import 'setup_status_response.dart';

class BlitzNetworkDevice {
  final String api;
  final bool reachable;
  final SetupStatusResponse setupStatus;

  BlitzNetworkDevice(this.api, this.reachable, this.setupStatus);
}
