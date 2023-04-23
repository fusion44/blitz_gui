# blitz_api_client.model.SendCoinsResponse

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**txid** | **String** | The transaction ID for this onchain payment | 
**address** | **String** | The base58 or bech32 encoded bitcoin address where the onchain funds where sent to | 
**amount** | **int** | The number of bitcoin denominated in satoshis which where sent | 
**fees** | **int** | The number of bitcoin denominated in satoshis which where paid as fees | [optional] 
**label** | **String** | The label used for the transaction. Ignored by CLN backend. | [optional] [default to '']

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


