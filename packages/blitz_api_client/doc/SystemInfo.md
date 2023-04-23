# blitz_api_client.model.SystemInfo

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**alias** | **String** | Name of the node (same as Lightning alias) | [optional] [default to '']
**color** | **String** | The color of the current node in hex code format | 
**platform** | [**APIPlatform**](APIPlatform.md) | The platform this API is running on. | [optional] 
**platformVersion** | **String** | The version of this platform | [optional] [default to '']
**apiVersion** | **String** | Version of the API software on this system. | 
**torWebUi** | **String** | WebUI TOR address | [optional] [default to '']
**torApi** | **String** | API TOR address | [optional] [default to '']
**lanWebUi** | **String** | WebUI LAN address | [optional] [default to '']
**lanApi** | **String** | API LAN address | [optional] [default to '']
**sshAddress** | **String** | Address to ssh into on local LAN (e.g. `ssh admin@192.168.1.28` | 
**chain** | **String** | The current chain this node is connected to (mainnet, testnet or signet) | 
**codeVersion** | **String** | [RaspiBlitz only] The code version. | [optional] [default to '']

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


