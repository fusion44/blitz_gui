# blitz_api_client.model.SoftFork

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** | Name of the softfork | 
**type** | **String** | One of \"buried\", \"bip9\" | 
**active** | **bool** | True **if** the rules are enforced for the mempool and the next block | 
**bip9** | [**Bip9**](Bip9.md) |  | [optional] 
**height** | **int** | Height of the first block which the rules are or will be enforced (only for `buried` type, or `bip9` type with `active` status) | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


