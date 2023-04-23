# blitz_api_client.model.Bip9Statistics

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**period** | **int** | The length in blocks of the BIP9 signalling period | 
**threshold** | **int** | The number of blocks with the version bit set required to activate the feature | 
**elapsed** | **int** | The number of blocks elapsed since the beginning of the current period | 
**count** | **int** | The number of blocks with the version bit set in the current period | 
**possible** | **bool** | False if there are not enough blocks left in this period to pass activation threshold | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


