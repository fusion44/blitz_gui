# blitz_api_client.model.PaymentRequest

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**destination** | **String** |  | 
**paymentHash** | **String** |  | 
**numSatoshis** | **int** | Deprecated. User num_msat instead | [optional] 
**timestamp** | **int** |  | 
**expiry** | **int** |  | 
**description** | **String** |  | 
**descriptionHash** | **String** |  | [optional] 
**fallbackAddr** | **String** |  | [optional] 
**cltvExpiry** | **int** |  | 
**routeHints** | [**BuiltList&lt;RouteHint&gt;**](RouteHint.md) | A list of [HopHint] for the RouteHint | [optional] [default to ListBuilder()]
**paymentAddr** | **String** | The payment address in hex format | [optional] [default to '']
**numMsat** | **int** |  | [optional] 
**features** | [**BuiltList&lt;FeaturesEntry&gt;**](FeaturesEntry.md) |  | [optional] [default to ListBuilder()]
**currency** | **String** | Optional requested currency of the payment.  | [optional] [default to '']

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


