# blitz_api_client.model.BlockchainInfo

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**chain** | **String** | Current network name(main, test, regtest) | 
**blocks** | **int** | The height of the most-work fully-validated chain. The genesis block has height 0 | 
**headers** | **int** | The current number of headers we have validated | 
**bestBlockHash** | **String** | The hash of the currently best block | 
**difficulty** | **int** | The current difficulty | 
**mediantime** | **int** | Median time for the current best block | 
**verificationProgress** | **num** | Estimate of verification progress[0..1] | 
**initialBlockDownload** | **bool** | Estimate of whether this node is in Initial Block Download mode | 
**chainwork** | **String** | total amount of work in active chain, in hexadecimal | 
**sizeOnDisk** | **int** | The estimated size of the block and undo files on disk | 
**pruned** | **bool** | If the blocks are subject to pruning | 
**pruneHeight** | **int** | Lowest-height complete block stored(only present if pruning is enabled) | [optional] 
**automaticPruning** | **bool** | Whether automatic pruning is enabled(only present if pruning is enabled) | [optional] 
**pruneTargetSize** | **int** | The target size used by pruning(only present if automatic pruning is enabled) | [optional] 
**warnings** | **String** | Any network and blockchain warnings | 
**softforks** | [**BuiltList&lt;SoftFork&gt;**](SoftFork.md) | Status of softforks | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


