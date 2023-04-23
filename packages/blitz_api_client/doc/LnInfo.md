# blitz_api_client.model.LnInfo

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**implementation** | **String** | Lightning software implementation (LND, CLN) | 
**version** | **String** | The version of the software that the node is running. | 
**commitHash** | **String** | The SHA1 commit hash that the daemon is compiled with. | 
**identityPubkey** | **String** |  | [optional] [default to 'The identity pubkey of the current node.']
**identityUri** | **String** |  | [optional] [default to 'The complete URI (pubkey@physicaladdress:port) the current node.']
**alias** | **String** | The alias of the node. | 
**color** | **String** | The color of the current node in hex code format. | 
**numPendingChannels** | **int** | Number of pending channels. | 
**numActiveChannels** | **int** | Number of active channels. | 
**numInactiveChannels** | **int** | Number of inactive channels. | 
**numPeers** | **int** | Number of peers. | 
**blockHeight** | **int** | The node's current view of the height of the best block. Only available with LND. | 
**blockHash** | **String** | The node's current view of the hash of the best block. Only available with LND. | [optional] [default to '']
**bestHeaderTimestamp** | **int** | Timestamp of the block best known to the wallet. Only available with LND. | [optional] 
**syncedToChain** | **bool** | Whether the wallet's view is synced to the main chain. Only available with LND. | [optional] 
**syncedToGraph** | **bool** | Whether we consider ourselves synced with the public channel graph. Only available with LND. | [optional] 
**chains** | [**BuiltList&lt;Chain&gt;**](Chain.md) | A list of active chains the node is connected to | [optional] [default to ListBuilder()]
**uris** | **BuiltList&lt;String&gt;** | The URIs of the current node. | [optional] [default to ListBuilder()]
**features** | [**BuiltList&lt;FeaturesEntry&gt;**](FeaturesEntry.md) | Features that our node has advertised in our init message node announcements and invoices. Not yet implemented with CLN | [optional] [default to ListBuilder()]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


