# blitz_api_client.model.LightningInfoLite

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**implementation** | **String** | Lightning software implementation (LND, c-lightning) | 
**version** | **String** | Version of the implementation | 
**identityPubkey** | **String** | The identity pubkey of the current node | 
**identityUri** | **String** | The complete URI of the current node | 
**numPendingChannels** | **int** | Number of pending channels | 
**numActiveChannels** | **int** | Number of active channels | 
**numInactiveChannels** | **int** | Number of inactive channels | 
**numPeers** | **int** | Number of peers | 
**blockHeight** | **int** | The node's current view of the height of the best block | 
**syncedToChain** | **bool** | Whether the wallet's view is synced to the main chain | [optional] 
**syncedToGraph** | **bool** | Whether we consider ourselves synced with the public channel graph. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


