import 'package:blitz_api_client/blitz_api_client.dart';
import 'package:test/test.dart';

/// tests for AppsApi
void main() {
  final instance = BlitzApiClient().getAppsApi();

  group(AppsApi, () {
    // Install app
    //
    //Future<JsonObject> appsInstallAppsInstallNamePost(String name) async
    test('test appsInstallAppsInstallNamePost', () async {
      // TODO
    });

    // Uninstall app
    //
    //Future<JsonObject> appsInstallAppsUninstallNamePost(String name, UninstallData uninstallData) async
    test('test appsInstallAppsUninstallNamePost', () async {
      // TODO
    });

    // Get the status available apps.
    //
    //Future<JsonObject> appsStatusAppsStatusGet() async
    test('test appsStatusAppsStatusGet', () async {
      // TODO
    });

    // Get the status of a single app by id.
    //
    //Future<JsonObject> appsStatusAppsStatusIdGet(JsonObject id) async
    test('test appsStatusAppsStatusIdGet', () async {
      // TODO
    });

    // Subscribe to status changes of currently installed apps.
    //
    //Future<JsonObject> appsStatusSubAppsStatusSubGet() async
    test('test appsStatusSubAppsStatusSubGet', () async {
      // TODO
    });
  });
}
