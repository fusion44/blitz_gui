# blitz_api_client.model.SendCoinsInput

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**address** | **String** | The base58 or bech32 encoded bitcoin address to send coins to on-chain | 
**targetConf** | **int** | The number of blocks that the transaction *should* confirm in, will be used for fee estimation | [optional] 
**satPerVbyte** | **int** | A manual fee expressed in sat/vbyte that should be used when crafting the transaction (default: 0) | [optional] 
**minConfs** | **int** | The minimum number of confirmations each one of your outputs used for the transaction must satisfy | [optional] [default to 1]
**label** | **String** | A label for the transaction. Ignored by CLN backend. | [optional] [default to '']
**sendAll** | **bool** | Send all available on-chain funds from the wallet. Will be executed `amount` is **0** | [optional] [default to false]
**amount** | **int** | The number of bitcoin denominated in satoshis to send. Must not be set when `send_all` is true. | [optional] [default to 0]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


