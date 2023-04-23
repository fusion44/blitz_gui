# blitz_api_client.model.WalletBalance

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**onchainConfirmedBalance** | **int** | Confirmed onchain balance (more than three confirmations) in sat | 
**onchainTotalBalance** | **int** | Total combined onchain balance in sat | 
**onchainUnconfirmedBalance** | **int** | Unconfirmed onchain balance (less than three confirmations) in sat | 
**channelLocalBalance** | **int** | Sum of channels local balances in msat | 
**channelRemoteBalance** | **int** | Sum of channels remote balances in msat. | 
**channelUnsettledLocalBalance** | **int** | Sum of channels local unsettled balances in msat. | 
**channelUnsettledRemoteBalance** | **int** | Sum of channels remote unsettled balances in msat. | 
**channelPendingOpenLocalBalance** | **int** | Sum of channels pending local balances in msat. | 
**channelPendingOpenRemoteBalance** | **int** | Sum of channels pending remote balances in msat. | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


