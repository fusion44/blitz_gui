# blitz_api_client.model.Payment

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**paymentHash** | **String** | The payment hash | 
**paymentPreimage** | **String** | The payment preimage | [optional] 
**valueMsat** | **int** | The value of the payment in milli-satoshis | 
**paymentRequest** | **String** | The optional payment request being fulfilled. | [optional] 
**status** | [**PaymentStatus**](PaymentStatus.md) | The status of the payment. | [optional] 
**feeMsat** | **int** | The fee paid for this payment in msat | 
**creationTimeNs** | **int** | The time in UNIX nanoseconds at which the payment was created. | 
**htlcs** | [**BuiltList&lt;HTLCAttempt&gt;**](HTLCAttempt.md) | The HTLCs made in attempt to settle the payment. | [optional] [default to ListBuilder()]
**paymentIndex** | **int** | The payment index. Only set with LND, 0 otherwise. | [optional] [default to 0]
**label** | **String** | The payment label. Only set with CLN, empty otherwise. | [optional] [default to '']
**failureReason** | [**PaymentFailureReason**](PaymentFailureReason.md) | The failure reason | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


