# blitz_api_client.api.SystemApi

## Load the API package
```dart
import 'package:blitz_api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**systemChangePasswordSystemChangePasswordPost**](SystemApi.md#systemchangepasswordsystemchangepasswordpost) | **POST** /system/change-password | Endpoint to change your password
[**systemConnectionInfoSystemConnectionInfoGet**](SystemApi.md#systemconnectioninfosystemconnectioninfoget) | **GET** /system/connection-info | Get credential information to connect external apps.
[**systemGetDebugLogsRawSystemGetDebugLogsRawGet**](SystemApi.md#systemgetdebuglogsrawsystemgetdebuglogsrawget) | **GET** /system/get-debug-logs-raw | Get raw system logs as a text string.
[**systemGetSystemInfoSystemGetSystemInfoGet**](SystemApi.md#systemgetsysteminfosystemgetsysteminfoget) | **GET** /system/get-system-info | Get system status information
[**systemHardwareInfoSubSystemHardwareInfoSubGet**](SystemApi.md#systemhardwareinfosubsystemhardwareinfosubget) | **GET** /system/hardware-info-sub | Subscribe to hardware status information.
[**systemHardwareInfoSystemHardwareInfoGet**](SystemApi.md#systemhardwareinfosystemhardwareinfoget) | **GET** /system/hardware-info | Get hardware status information.
[**systemLoginSystemLoginPost**](SystemApi.md#systemloginsystemloginpost) | **POST** /system/login | Logs the user in with the current password
[**systemRebootSystemRebootPost**](SystemApi.md#systemrebootsystemrebootpost) | **POST** /system/reboot | Reboots the system
[**systemRefreshTokenSystemRefreshTokenPost**](SystemApi.md#systemrefreshtokensystemrefreshtokenpost) | **POST** /system/refresh-token | Endpoint to refresh an authentication token
[**systemShutdownSystemShutdownPost**](SystemApi.md#systemshutdownsystemshutdownpost) | **POST** /system/shutdown | Shuts the system down


# **systemChangePasswordSystemChangePasswordPost**
> JsonObject systemChangePasswordSystemChangePasswordPost(oldPassword, newPassword, type)

Endpoint to change your password

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getSystemApi();
final String oldPassword = oldPassword_example; // String | 
final String newPassword = newPassword_example; // String | 
final String type = type_example; // String |  ℹ️ Used in **RaspiBlitz only**. Password A, B or C. Must be one of `[\"a\", \"b\", \"c\"]`

try {
    final response = api.systemChangePasswordSystemChangePasswordPost(oldPassword, newPassword, type);
    print(response);
} catch on DioError (e) {
    print('Exception when calling SystemApi->systemChangePasswordSystemChangePasswordPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **oldPassword** | **String**|  | 
 **newPassword** | **String**|  | 
 **type** | **String**|  ℹ️ Used in **RaspiBlitz only**. Password A, B or C. Must be one of `[\"a\", \"b\", \"c\"]` | [optional] 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **systemConnectionInfoSystemConnectionInfoGet**
> ConnectionInfo systemConnectionInfoSystemConnectionInfoGet()

Get credential information to connect external apps.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getSystemApi();

try {
    final response = api.systemConnectionInfoSystemConnectionInfoGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling SystemApi->systemConnectionInfoSystemConnectionInfoGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ConnectionInfo**](ConnectionInfo.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **systemGetDebugLogsRawSystemGetDebugLogsRawGet**
> RawDebugLogData systemGetDebugLogsRawSystemGetDebugLogsRawGet()

Get raw system logs as a text string.

This endpoint will gather latest system logs and return it in a raw string. This endpoint will **not** return immediately because it gathers all data on time of the request.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getSystemApi();

try {
    final response = api.systemGetDebugLogsRawSystemGetDebugLogsRawGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling SystemApi->systemGetDebugLogsRawSystemGetDebugLogsRawGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**RawDebugLogData**](RawDebugLogData.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **systemGetSystemInfoSystemGetSystemInfoGet**
> SystemInfo systemGetSystemInfoSystemGetSystemInfoGet()

Get system status information

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getSystemApi();

try {
    final response = api.systemGetSystemInfoSystemGetSystemInfoGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling SystemApi->systemGetSystemInfoSystemGetSystemInfoGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SystemInfo**](SystemInfo.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **systemHardwareInfoSubSystemHardwareInfoSubGet**
> JsonObject systemHardwareInfoSubSystemHardwareInfoSubGet()

Subscribe to hardware status information.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getSystemApi();

try {
    final response = api.systemHardwareInfoSubSystemHardwareInfoSubGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling SystemApi->systemHardwareInfoSubSystemHardwareInfoSubGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **systemHardwareInfoSystemHardwareInfoGet**
> JsonObject systemHardwareInfoSystemHardwareInfoGet()

Get hardware status information.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getSystemApi();

try {
    final response = api.systemHardwareInfoSystemHardwareInfoGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling SystemApi->systemHardwareInfoSystemHardwareInfoGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **systemLoginSystemLoginPost**
> JsonObject systemLoginSystemLoginPost(loginInput)

Logs the user in with the current password

### Example
```dart
import 'package:blitz_api_client/api.dart';

final api = BlitzApiClient().getSystemApi();
final LoginInput loginInput = ; // LoginInput | 

try {
    final response = api.systemLoginSystemLoginPost(loginInput);
    print(response);
} catch on DioError (e) {
    print('Exception when calling SystemApi->systemLoginSystemLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginInput** | [**LoginInput**](LoginInput.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **systemRebootSystemRebootPost**
> bool systemRebootSystemRebootPost()

Reboots the system

Attempts to reboot the system.     Will send a `system_reboot_initiated` SSE message immediately to     all connected clients.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getSystemApi();

try {
    final response = api.systemRebootSystemRebootPost();
    print(response);
} catch on DioError (e) {
    print('Exception when calling SystemApi->systemRebootSystemRebootPost: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**bool**

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **systemRefreshTokenSystemRefreshTokenPost**
> JsonObject systemRefreshTokenSystemRefreshTokenPost()

Endpoint to refresh an authentication token

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getSystemApi();

try {
    final response = api.systemRefreshTokenSystemRefreshTokenPost();
    print(response);
} catch on DioError (e) {
    print('Exception when calling SystemApi->systemRefreshTokenSystemRefreshTokenPost: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **systemShutdownSystemShutdownPost**
> bool systemShutdownSystemShutdownPost()

Shuts the system down

Attempts to shutdown the system.     Will send a `system_shutdown_initiated` SSE message immediately to all     connected clients.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getSystemApi();

try {
    final response = api.systemShutdownSystemShutdownPost();
    print(response);
} catch on DioError (e) {
    print('Exception when calling SystemApi->systemShutdownSystemShutdownPost: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**bool**

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

