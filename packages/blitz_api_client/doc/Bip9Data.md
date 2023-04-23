# blitz_api_client.model.Bip9Data

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**status** | **String** | One of \"defined\", \"started\", \"locked_in\", \"active\", \"failed\"  | 
**bit** | **int** | the bit(0-28) in the block version field used to signal this softfork(only for `started` status) | [optional] 
**startTime** | **int** | The minimum median time past of a block at which the bit gains its meaning | 
**timeout** | **int** | The median time past of a block at which the deployment is considered failed if not yet locked in | 
**since** | **int** | Height of the first block to which the status applies | 
**minActivationHeight** | **int** | Minimum height of blocks for which the rules may be enforced | 
**statistics** | [**Statistics**](Statistics.md) |  | [optional] 
**height** | **int** | Height of the first block which the rules are or will be enforced(only for `buried` type, or `bip9` type with `active` status) | [optional] 
**active** | **bool** | True if the rules are enforced for the mempool and the next block | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


