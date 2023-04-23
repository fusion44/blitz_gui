# blitz_api_client.model.ConnectionInfo

## Load the model package
```dart
import 'package:blitz_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**lndAdminMacaroon** | **String** | lnd macaroon with admin rights in hexstring format | [optional] [default to '']
**lndInvoiceMacaroon** | **String** | lnd macaroon that only creates invoices in hexstring format | [optional] [default to '']
**lndReadonlyMacaroon** | **String** | lnd macaroon with only read-only rights in hexstring format | [optional] [default to '']
**lndTlsCert** | **String** | lnd tls cert in hexstring format | [optional] [default to '']
**lndRestOnion** | **String** | lnd rest api onion address | [optional] [default to '']
**lndBtcpayConnectionString** | **String** | connect BtcPay server locally to your lnd lightning node | [optional] [default to '']
**lndZeusConnectionString** | **String** | connect Zeus app to your lnd lightning node | [optional] [default to '']
**clRestZeusConnectionString** | **String** | connect Zeus app to your core lightning node over rest | [optional] [default to '']
**clRestMacaroon** | **String** | core lightning rest macaroon | [optional] [default to '']
**clRestOnion** | **String** | core lightning rest onion address | [optional] [default to '']

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


