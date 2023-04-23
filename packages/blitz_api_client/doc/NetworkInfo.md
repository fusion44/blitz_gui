# blitz_api_client.model.NetworkInfo

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**version** | **int** | The bitcoin core server version | 
**subversion** | **String** | The server subversion string | 
**protocolVersion** | **int** | The protocol version | 
**localServices** | **String** | The services we offer to the network, hex formatted | [optional] 
**localServicesNames** | **BuiltList&lt;String&gt;** | The services we offer to the network, in human-readable form | [optional] [default to ListBuilder()]
**localRelay** | **bool** | True if transaction relay is requested from peers | 
**timeOffset** | **int** | The time offset | 
**connections** | **int** | The total number of connections | 
**connectionsIn** | **int** | The number of inbound connections | 
**connectionsOut** | **int** | The number of outbound connections | 
**networkActive** | **bool** | Whether p2p networking is enabled | 
**networks** | [**BuiltList&lt;BtcNetwork&gt;**](BtcNetwork.md) | Information per network | 
**relayFee** | **int** | Minimum relay fee for transactions in BTC/kB | 
**incrementalFee** | **int** | Minimum fee increment for mempool limiting or BIP 125 replacement in BTC/kB | 
**localAddresses** | [**BuiltList&lt;BtcLocalAddress&gt;**](BtcLocalAddress.md) | List of local addresses | [optional] [default to ListBuilder()]
**warnings** | **String** | Any network and blockchain warnings | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


