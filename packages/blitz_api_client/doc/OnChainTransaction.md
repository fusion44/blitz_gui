# blitz_api_client.model.OnChainTransaction

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**txHash** | **String** | The transaction hash | 
**amount** | **int** | The transaction amount, denominated in satoshis | 
**numConfirmations** | **int** | The number of confirmations | 
**blockHeight** | **int** | The height of the block this transaction was included in | 
**timeStamp** | **int** | Timestamp of this transaction | 
**totalFees** | **int** | Fees paid for this transaction | 
**destAddresses** | **BuiltList&lt;String&gt;** | Addresses that received funds for this transaction | [optional] [default to ListBuilder()]
**label** | **String** | An optional label that was set on transaction broadcast. | [optional] [default to '']

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


