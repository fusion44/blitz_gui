import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

// tests for SystemInfo
void main() {
  final instance = SystemInfoBuilder();
  // TODO add properties to the builder and call build()

  group(SystemInfo, () {
    // Name of the node (same as Lightning alias)
    // String alias (default value: '')
    test('to test the property `alias`', () async {
      // TODO
    });

    // The color of the current node in hex code format
    // String color
    test('to test the property `color`', () async {
      // TODO
    });

    // The platform this API is running on.
    // APIPlatform platform
    test('to test the property `platform`', () async {
      // TODO
    });

    // The version of this platform
    // String platformVersion (default value: '')
    test('to test the property `platformVersion`', () async {
      // TODO
    });

    // Version of the API software on this system.
    // String apiVersion
    test('to test the property `apiVersion`', () async {
      // TODO
    });

    // WebUI TOR address
    // String torWebUi (default value: '')
    test('to test the property `torWebUi`', () async {
      // TODO
    });

    // API TOR address
    // String torApi (default value: '')
    test('to test the property `torApi`', () async {
      // TODO
    });

    // WebUI LAN address
    // String lanWebUi (default value: '')
    test('to test the property `lanWebUi`', () async {
      // TODO
    });

    // API LAN address
    // String lanApi (default value: '')
    test('to test the property `lanApi`', () async {
      // TODO
    });

    // Address to ssh into on local LAN (e.g. `ssh admin@192.168.1.28`
    // String sshAddress
    test('to test the property `sshAddress`', () async {
      // TODO
    });

    // The current chain this node is connected to (mainnet, testnet or signet)
    // String chain
    test('to test the property `chain`', () async {
      // TODO
    });

    // [RaspiBlitz only] The code version.
    // String codeVersion (default value: '')
    test('to test the property `codeVersion`', () async {
      // TODO
    });
  });
}
