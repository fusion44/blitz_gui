# blitz_api_client.model.BtcInfo

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**blocks** | **int** | The height of the most-work fully-validated chain. The genesis block has height 0 | 
**headers** | **int** | The current number of headers we have validated | 
**verificationProgress** | **num** | Estimate of verification progress[0..1] | 
**difficulty** | **int** | The current difficulty | 
**sizeOnDisk** | **int** | The estimated size of the block and undo files on disk | 
**networks** | [**BuiltList&lt;BtcNetwork&gt;**](BtcNetwork.md) | Which networks are in use (ipv4, ipv6 or onion) | [optional] [default to ListBuilder()]
**version** | **int** | The bitcoin core server version | 
**subversion** | **String** | The server subversion string | 
**connectionsIn** | **int** | The number of inbound connections | 
**connectionsOut** | **int** | The number of outbound connections | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


