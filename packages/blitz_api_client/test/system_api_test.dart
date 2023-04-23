import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

/// tests for SystemApi
void main() {
  final instance = BlitzApiClient().getSystemApi();

  group(SystemApi, () {
    // Endpoint to change your password
    //
    //Future<JsonObject> systemChangePasswordSystemChangePasswordPost(String oldPassword, String newPassword, { String type }) async
    test('test systemChangePasswordSystemChangePasswordPost', () async {
      // TODO
    });

    // Get credential information to connect external apps.
    //
    //Future<ConnectionInfo> systemConnectionInfoSystemConnectionInfoGet() async
    test('test systemConnectionInfoSystemConnectionInfoGet', () async {
      // TODO
    });

    // Get raw system logs as a text string.
    //
    // This endpoint will gather latest system logs and return it in a raw string. This endpoint will **not** return immediately because it gathers all data on time of the request.
    //
    //Future<RawDebugLogData> systemGetDebugLogsRawSystemGetDebugLogsRawGet() async
    test('test systemGetDebugLogsRawSystemGetDebugLogsRawGet', () async {
      // TODO
    });

    // Get system status information
    //
    //Future<SystemInfo> systemGetSystemInfoSystemGetSystemInfoGet() async
    test('test systemGetSystemInfoSystemGetSystemInfoGet', () async {
      // TODO
    });

    // Subscribe to hardware status information.
    //
    //Future<JsonObject> systemHardwareInfoSubSystemHardwareInfoSubGet() async
    test('test systemHardwareInfoSubSystemHardwareInfoSubGet', () async {
      // TODO
    });

    // Get hardware status information.
    //
    //Future<JsonObject> systemHardwareInfoSystemHardwareInfoGet() async
    test('test systemHardwareInfoSystemHardwareInfoGet', () async {
      // TODO
    });

    // Logs the user in with the current password
    //
    //Future<JsonObject> systemLoginSystemLoginPost(LoginInput loginInput) async
    test('test systemLoginSystemLoginPost', () async {
      // TODO
    });

    // Reboots the system
    //
    // Attempts to reboot the system.     Will send a `system_reboot_initiated` SSE message immediately to     all connected clients.
    //
    //Future<bool> systemRebootSystemRebootPost() async
    test('test systemRebootSystemRebootPost', () async {
      // TODO
    });

    // Endpoint to refresh an authentication token
    //
    //Future<JsonObject> systemRefreshTokenSystemRefreshTokenPost() async
    test('test systemRefreshTokenSystemRefreshTokenPost', () async {
      // TODO
    });

    // Shuts the system down
    //
    // Attempts to shutdown the system.     Will send a `system_shutdown_initiated` SSE message immediately to all     connected clients.
    //
    //Future<bool> systemShutdownSystemShutdownPost() async
    test('test systemShutdownSystemShutdownPost', () async {
      // TODO
    });
  });
}
