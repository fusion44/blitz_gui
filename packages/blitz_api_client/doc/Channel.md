# blitz_api_client.model.Channel

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**channelId** | **String** | The unique identifier of the channel | [optional] [default to '']
**state** | [**ChannelState**](ChannelState.md) | The state of the channel | 
**active** | **bool** | Whether the channel is active or not. True if the channel is not closing and the peer is online. | 
**peerPublickey** | **String** | The public key of the peer | 
**peerAlias** | **String** | The alias of the peer if available | [optional] [default to '']
**balanceLocal** | **int** | This node's current balance in this channel | [optional] [default to 0]
**balanceRemote** | **int** | The counterparty's current balance in this channel | [optional] [default to 0]
**balanceCapacity** | **int** | The total capacity of the channel | [optional] [default to 0]
**dualFunded** | **bool** | Whether the channel was dual funded or not | [optional] 
**initiator** | [**ChannelInitiator**](ChannelInitiator.md) | Whether the channel was initiated by us, our peer or both | [optional] 
**closer** | [**ChannelInitiator**](ChannelInitiator.md) | If state is closing, this shows who initiated the close. None, if not in a closing state. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


