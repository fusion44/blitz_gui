# blitz_api_client.api.AppsApi

## Load the API package
```dart
import 'package:blitz_api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**appsInstallAppsInstallNamePost**](AppsApi.md#appsinstallappsinstallnamepost) | **POST** /apps/install/{name} | Install app
[**appsInstallAppsUninstallNamePost**](AppsApi.md#appsinstallappsuninstallnamepost) | **POST** /apps/uninstall/{name} | Uninstall app
[**appsStatusAppsStatusGet**](AppsApi.md#appsstatusappsstatusget) | **GET** /apps/status | Get the status available apps.
[**appsStatusAppsStatusIdGet**](AppsApi.md#appsstatusappsstatusidget) | **GET** /apps/status/{id} | Get the status of a single app by id.
[**appsStatusSubAppsStatusSubGet**](AppsApi.md#appsstatussubappsstatussubget) | **GET** /apps/status-sub | Subscribe to status changes of currently installed apps.


# **appsInstallAppsInstallNamePost**
> JsonObject appsInstallAppsInstallNamePost(name)

Install app

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getAppsApi();
final String name = name_example; // String | 

try {
    final response = api.appsInstallAppsInstallNamePost(name);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AppsApi->appsInstallAppsInstallNamePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **appsInstallAppsUninstallNamePost**
> JsonObject appsInstallAppsUninstallNamePost(name, uninstallData)

Uninstall app

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getAppsApi();
final String name = name_example; // String | 
final UninstallData uninstallData = ; // UninstallData | 

try {
    final response = api.appsInstallAppsUninstallNamePost(name, uninstallData);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AppsApi->appsInstallAppsUninstallNamePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **uninstallData** | [**UninstallData**](UninstallData.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **appsStatusAppsStatusGet**
> JsonObject appsStatusAppsStatusGet()

Get the status available apps.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getAppsApi();

try {
    final response = api.appsStatusAppsStatusGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling AppsApi->appsStatusAppsStatusGet: $e\n');
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

# **appsStatusAppsStatusIdGet**
> JsonObject appsStatusAppsStatusIdGet(id)

Get the status of a single app by id.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getAppsApi();
final JsonObject id = ; // JsonObject | 

try {
    final response = api.appsStatusAppsStatusIdGet(id);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AppsApi->appsStatusAppsStatusIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | [**JsonObject**](.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **appsStatusSubAppsStatusSubGet**
> JsonObject appsStatusSubAppsStatusSubGet()

Subscribe to status changes of currently installed apps.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getAppsApi();

try {
    final response = api.appsStatusSubAppsStatusSubGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling AppsApi->appsStatusSubAppsStatusSubGet: $e\n');
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

