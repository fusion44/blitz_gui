# blitz_api_client.model.RawTransaction

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**inActiveChain** | **bool** | Whether specified block is in the active chain or not (only present with explicit \"blockhash\" argument) | [optional] 
**txid** | **String** | The transaction id (same as provided) | 
**hash** | **String** | The transaction hash (differs from txid for witness transactions) | 
**size** | **int** | The serialized transaction size | 
**vsize** | **int** | The virtual transaction size (differs from size for witness transactions) | 
**weight** | **int** | The transaction's weight (between vsize*4 - 3 and vsize*4) | 
**version** | **int** | The version | 
**locktime** | **int** | The lock time | 
**vin** | [**BuiltList&lt;JsonObject&gt;**](JsonObject.md) | The transaction's inputs | 
**vout** | [**BuiltList&lt;JsonObject&gt;**](JsonObject.md) | The transaction's outputs | 
**blockhash** | **String** | The block hash | 
**confirmations** | **int** | The number of confirmations | 
**blocktime** | **int** | The block time in seconds since epoch (Jan 1 1970 GMT) | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


