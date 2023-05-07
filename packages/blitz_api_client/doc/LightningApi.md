# blitz_api_client.api.LightningApi

## Load the API package
```dart
import 'package:blitz_api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**lightningAddInvoiceLightningAddInvoicePost**](LightningApi.md#lightningaddinvoicelightningaddinvoicepost) | **POST** /lightning/add-invoice | Addinvoice adds a new Invoice to the database.
[**lightningCloseChannelLightningCloseChannelPost**](LightningApi.md#lightningclosechannellightningclosechannelpost) | **POST** /lightning/close-channel | close a channel
[**lightningDecodePayReqLightningDecodePayReqGet**](LightningApi.md#lightningdecodepayreqlightningdecodepayreqget) | **GET** /lightning/decode-pay-req | DecodePayReq takes an encoded payment request string and attempts to decode it, returning a full description of the conditions encoded within the payment request.
[**lightningGetBalanceLightningGetBalanceGet**](LightningApi.md#lightninggetbalancelightninggetbalanceget) | **GET** /lightning/get-balance | Get the current on chain and channel balances of the lighting wallet.
[**lightningGetFeeRevenueLightningGetFeeRevenueGet**](LightningApi.md#lightninggetfeerevenuelightninggetfeerevenueget) | **GET** /lightning/get-fee-revenue | Returns the daily, weekly and monthly fee revenue earned.
[**lightningGetInfoLightningGetInfoGet**](LightningApi.md#lightninggetinfolightninggetinfoget) | **GET** /lightning/get-info | Request information about the currently running lightning node.
[**lightningGetInfoLiteLightningGetInfoLiteGet**](LightningApi.md#lightninggetinfolitelightninggetinfoliteget) | **GET** /lightning/get-info-lite | Get lightweight current lightning info. Less verbose version of /lightning/get-info
[**lightningListAllTxLightningListAllTxGet**](LightningApi.md#lightninglistalltxlightninglistalltxget) | **GET** /lightning/list-all-tx | Lists all on-chain transactions, payments and invoices in the wallet
[**lightningListChannelsLightningListChannelsGet**](LightningApi.md#lightninglistchannelslightninglistchannelsget) | **GET** /lightning/list-channels | Returns a list of all channels
[**lightningListInvoicesLightningListInvoicesGet**](LightningApi.md#lightninglistinvoiceslightninglistinvoicesget) | **GET** /lightning/list-invoices | Lists all invoices from the wallet. Modeled after LND implementation.
[**lightningListOnchainTxLightningListOnchainTxGet**](LightningApi.md#lightninglistonchaintxlightninglistonchaintxget) | **GET** /lightning/list-onchain-tx | Lists all onchain transactions from the wallet
[**lightningListPaymentsLightningListPaymentsGet**](LightningApi.md#lightninglistpaymentslightninglistpaymentsget) | **GET** /lightning/list-payments | Returns a list of all outgoing payments. Modeled after LND implementation.
[**lightningNewAddressLightningNewAddressPost**](LightningApi.md#lightningnewaddresslightningnewaddresspost) | **POST** /lightning/new-address | Generate a new on-chain address
[**lightningOpenChannelLightningOpenChannelPost**](LightningApi.md#lightningopenchannellightningopenchannelpost) | **POST** /lightning/open-channel | open a new lightning channel
[**lightningSendCoinsLightningSendCoinsPost**](LightningApi.md#lightningsendcoinslightningsendcoinspost) | **POST** /lightning/send-coins | Attempt to send on-chain funds.
[**lightningSendPaymentLightningSendPaymentPost**](LightningApi.md#lightningsendpaymentlightningsendpaymentpost) | **POST** /lightning/send-payment | Attempt to pay a payment request.
[**lightningUnlockWalletLightningUnlockWalletPost**](LightningApi.md#lightningunlockwalletlightningunlockwalletpost) | **POST** /lightning/unlock-wallet | Unlocks a locked wallet.


# **lightningAddInvoiceLightningAddInvoicePost**
> Invoice lightningAddInvoiceLightningAddInvoicePost(valueMsat, memo, expiry, isKeysend)

Addinvoice adds a new Invoice to the database.

For additional information see [LND docs](https://api.lightning.community/#addinvoice)

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();
final int valueMsat = 56; // int | The amount of msat of the invoice
final String memo = memo_example; // String | The memo of the invoice
final int expiry = 56; // int | Expiry time in seconds
final bool isKeysend = true; // bool | LND only: Whether this invoice is a keysend invoice.

try {
    final response = api.lightningAddInvoiceLightningAddInvoicePost(valueMsat, memo, expiry, isKeysend);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningAddInvoiceLightningAddInvoicePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **valueMsat** | **int**| The amount of msat of the invoice | 
 **memo** | **String**| The memo of the invoice | [optional] [default to '']
 **expiry** | **int**| Expiry time in seconds | [optional] [default to 3600]
 **isKeysend** | **bool**| LND only: Whether this invoice is a keysend invoice. | [optional] [default to false]

### Return type

[**Invoice**](Invoice.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningCloseChannelLightningCloseChannelPost**
> String lightningCloseChannelLightningCloseChannelPost(channelId, forceClose)

close a channel

For additional information see [LND docs](https://api.lightning.community/#closechannel)

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();
final String channelId = channelId_example; // String | 
final bool forceClose = true; // bool | 

try {
    final response = api.lightningCloseChannelLightningCloseChannelPost(channelId, forceClose);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningCloseChannelLightningCloseChannelPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channelId** | **String**|  | 
 **forceClose** | **bool**|  | 

### Return type

**String**

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningDecodePayReqLightningDecodePayReqGet**
> PaymentRequest lightningDecodePayReqLightningDecodePayReqGet(payReq)

DecodePayReq takes an encoded payment request string and attempts to decode it, returning a full description of the conditions encoded within the payment request.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();
final String payReq = payReq_example; // String | The payment request string to be decoded

try {
    final response = api.lightningDecodePayReqLightningDecodePayReqGet(payReq);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningDecodePayReqLightningDecodePayReqGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payReq** | **String**| The payment request string to be decoded | 

### Return type

[**PaymentRequest**](PaymentRequest.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningGetBalanceLightningGetBalanceGet**
> WalletBalance lightningGetBalanceLightningGetBalanceGet()

Get the current on chain and channel balances of the lighting wallet.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();

try {
    final response = api.lightningGetBalanceLightningGetBalanceGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningGetBalanceLightningGetBalanceGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**WalletBalance**](WalletBalance.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningGetFeeRevenueLightningGetFeeRevenueGet**
> FeeRevenue lightningGetFeeRevenueLightningGetFeeRevenueGet()

Returns the daily, weekly and monthly fee revenue earned.

Currently, year and total fees are always null. Backends don't return these values by default. Implementation in BlitzAPI is a [to-do](https://github.com/fusion44/blitz_api/issues/64).

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();

try {
    final response = api.lightningGetFeeRevenueLightningGetFeeRevenueGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningGetFeeRevenueLightningGetFeeRevenueGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**FeeRevenue**](FeeRevenue.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningGetInfoLightningGetInfoGet**
> LnInfo lightningGetInfoLightningGetInfoGet()

Request information about the currently running lightning node.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();

try {
    final response = api.lightningGetInfoLightningGetInfoGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningGetInfoLightningGetInfoGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**LnInfo**](LnInfo.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningGetInfoLiteLightningGetInfoLiteGet**
> LightningInfoLite lightningGetInfoLiteLightningGetInfoLiteGet()

Get lightweight current lightning info. Less verbose version of /lightning/get-info

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();

try {
    final response = api.lightningGetInfoLiteLightningGetInfoLiteGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningGetInfoLiteLightningGetInfoLiteGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**LightningInfoLite**](LightningInfoLite.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningListAllTxLightningListAllTxGet**
> BuiltList<GenericTx> lightningListAllTxLightningListAllTxGet(successfulOnly, indexOffset, maxTx, reversed)

Lists all on-chain transactions, payments and invoices in the wallet

Returns a list with all on-chain transaction, payments and invoices combined into one list.     The index of each tx is only valid for each identical set of parameters.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();
final bool successfulOnly = true; // bool | If set, only successful transaction will be returned in the response.
final int indexOffset = 56; // int | The index of an transaction that will be used as either the start or end of a query to determine which invoices should be returned in the response.
final int maxTx = 56; // int | The max number of transaction to return in the response to this query. Will return all transactions when set to 0 or null.
final bool reversed = true; // bool | If set, the transactions returned will result from seeking backwards from the specified index offset. This can be used to paginate backwards.

try {
    final response = api.lightningListAllTxLightningListAllTxGet(successfulOnly, indexOffset, maxTx, reversed);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningListAllTxLightningListAllTxGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **successfulOnly** | **bool**| If set, only successful transaction will be returned in the response. | [optional] [default to false]
 **indexOffset** | **int**| The index of an transaction that will be used as either the start or end of a query to determine which invoices should be returned in the response. | [optional] [default to 0]
 **maxTx** | **int**| The max number of transaction to return in the response to this query. Will return all transactions when set to 0 or null. | [optional] [default to 0]
 **reversed** | **bool**| If set, the transactions returned will result from seeking backwards from the specified index offset. This can be used to paginate backwards. | [optional] [default to false]

### Return type

[**BuiltList&lt;GenericTx&gt;**](GenericTx.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningListChannelsLightningListChannelsGet**
> BuiltList<Channel> lightningListChannelsLightningListChannelsGet(includeClosed, peerAliasLookup)

Returns a list of all channels

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();
final bool includeClosed = true; // bool | If true, then include closed channels.
final bool peerAliasLookup = true; // bool | If true, then include the peer alias of the channel. ⚠️ Enabling this flag does come with a performance cost in the form of another roundtrip to the node.

try {
    final response = api.lightningListChannelsLightningListChannelsGet(includeClosed, peerAliasLookup);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningListChannelsLightningListChannelsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **includeClosed** | **bool**| If true, then include closed channels. | [optional] [default to true]
 **peerAliasLookup** | **bool**| If true, then include the peer alias of the channel. ⚠️ Enabling this flag does come with a performance cost in the form of another roundtrip to the node. | [optional] [default to false]

### Return type

[**BuiltList&lt;Channel&gt;**](Channel.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningListInvoicesLightningListInvoicesGet**
> BuiltList<Invoice> lightningListInvoicesLightningListInvoicesGet(pendingOnly, indexOffset, numMaxInvoices, reversed)

Lists all invoices from the wallet. Modeled after LND implementation.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();
final bool pendingOnly = true; // bool | If set, only invoices that are not settled and not canceled will be returned in the response.
final int indexOffset = 56; // int | The index of an invoice that will be used as either the start or end of a query to determine which invoices should be returned in the response.
final int numMaxInvoices = 56; // int | The max number of invoices to return in the response to this query. Will return all invoices when set to 0 or null.
final bool reversed = true; // bool | If set, the invoices returned will result from seeking backwards from the specified index offset. This can be used to paginate backwards.

try {
    final response = api.lightningListInvoicesLightningListInvoicesGet(pendingOnly, indexOffset, numMaxInvoices, reversed);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningListInvoicesLightningListInvoicesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pendingOnly** | **bool**| If set, only invoices that are not settled and not canceled will be returned in the response. | [optional] [default to false]
 **indexOffset** | **int**| The index of an invoice that will be used as either the start or end of a query to determine which invoices should be returned in the response. | [optional] [default to 0]
 **numMaxInvoices** | **int**| The max number of invoices to return in the response to this query. Will return all invoices when set to 0 or null. | [optional] [default to 0]
 **reversed** | **bool**| If set, the invoices returned will result from seeking backwards from the specified index offset. This can be used to paginate backwards. | [optional] [default to false]

### Return type

[**BuiltList&lt;Invoice&gt;**](Invoice.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningListOnchainTxLightningListOnchainTxGet**
> BuiltList<OnChainTransaction> lightningListOnchainTxLightningListOnchainTxGet()

Lists all onchain transactions from the wallet

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();

try {
    final response = api.lightningListOnchainTxLightningListOnchainTxGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningListOnchainTxLightningListOnchainTxGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;OnChainTransaction&gt;**](OnChainTransaction.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningListPaymentsLightningListPaymentsGet**
> BuiltList<Payment> lightningListPaymentsLightningListPaymentsGet(includeIncomplete, indexOffset, maxPayments, reversed)

Returns a list of all outgoing payments. Modeled after LND implementation.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();
final bool includeIncomplete = true; // bool | If true, then return payments that have not yet fully completed. This means that pending payments, as well as failed payments will show up if this field is set to true. This flag doesn't change the meaning of the indices, which are tied to individual payments.
final int indexOffset = 56; // int | The index of a payment that will be used as either the start or end of a query to determine which payments should be returned in the response. The index_offset is exclusive. In the case of a zero index_offset, the query will start with the oldest payment when paginating forwards, or will end with the most recent payment when paginating backwards.
final int maxPayments = 56; // int | The maximal number of payments returned in the response to this query.
final bool reversed = true; // bool | If set, the payments returned will result from seeking backwards from the specified index offset. This can be used to paginate backwards. The order of the returned payments is always oldest first (ascending index order).

try {
    final response = api.lightningListPaymentsLightningListPaymentsGet(includeIncomplete, indexOffset, maxPayments, reversed);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningListPaymentsLightningListPaymentsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **includeIncomplete** | **bool**| If true, then return payments that have not yet fully completed. This means that pending payments, as well as failed payments will show up if this field is set to true. This flag doesn't change the meaning of the indices, which are tied to individual payments. | [optional] [default to true]
 **indexOffset** | **int**| The index of a payment that will be used as either the start or end of a query to determine which payments should be returned in the response. The index_offset is exclusive. In the case of a zero index_offset, the query will start with the oldest payment when paginating forwards, or will end with the most recent payment when paginating backwards. | [optional] [default to 0]
 **maxPayments** | **int**| The maximal number of payments returned in the response to this query. | [optional] [default to 0]
 **reversed** | **bool**| If set, the payments returned will result from seeking backwards from the specified index offset. This can be used to paginate backwards. The order of the returned payments is always oldest first (ascending index order). | [optional] [default to false]

### Return type

[**BuiltList&lt;Payment&gt;**](Payment.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningNewAddressLightningNewAddressPost**
> String lightningNewAddressLightningNewAddressPost(newAddressInput)

Generate a new on-chain address

Generate a wallet new address. Address-types has to be one of: * **p2wkh**:  Pay to witness key hash (bech32) * **np2wkh**: Pay to nested witness key hash (LND only)  > ℹ️ _CLN only supports and returns p2wkh (bech32) addresses_

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();
final NewAddressInput newAddressInput = ; // NewAddressInput | 

try {
    final response = api.lightningNewAddressLightningNewAddressPost(newAddressInput);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningNewAddressLightningNewAddressPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **newAddressInput** | [**NewAddressInput**](NewAddressInput.md)|  | 

### Return type

**String**

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningOpenChannelLightningOpenChannelPost**
> String lightningOpenChannelLightningOpenChannelPost(localFundingAmount, nodeURI, targetConfs, pushAmountSat)

open a new lightning channel

__open-channel__ attempts to open a channel with a peer.  ### LND: _target_conf_: The target number of blocks that the funding transaction should be confirmed by.  ### c-lightning: * Set _target_conf_ ==1: interpreted as urgent (aim for next block) * Set _target_conf_ >=2: interpreted as normal (next 4 blocks or so, **default**) * Set _target_cont_ >=10: interpreted as slow (next 100 blocks or so)  > 👉 See [https://lightning.readthedocs.io/lightning-txprepare.7.html](https://lightning.readthedocs.io/lightning-txprepare.7.html)

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();
final int localFundingAmount = 56; // int | The amount of satoshis to commit to the channel.
final String nodeURI = nodeURI_example; // String | The URI of the peer to open a channel with. Format: <pubkey>@<host>:<port>
final int targetConfs = 56; // int | The block target for the funding transaction.
final int pushAmountSat = 56; // int | The amount of sats to push to the peer.

try {
    final response = api.lightningOpenChannelLightningOpenChannelPost(localFundingAmount, nodeURI, targetConfs, pushAmountSat);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningOpenChannelLightningOpenChannelPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **localFundingAmount** | **int**| The amount of satoshis to commit to the channel. | 
 **nodeURI** | **String**| The URI of the peer to open a channel with. Format: <pubkey>@<host>:<port> | 
 **targetConfs** | **int**| The block target for the funding transaction. | [optional] [default to 3]
 **pushAmountSat** | **int**| The amount of sats to push to the peer. | [optional] 

### Return type

**String**

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningSendCoinsLightningSendCoinsPost**
> SendCoinsResponse lightningSendCoinsLightningSendCoinsPost(sendCoinsInput)

Attempt to send on-chain funds.

__send-coins__ executes a request to send coins to a particular address.  ### LND: If neither __target_conf__, or __sat_per_vbyte__ are set, then the internal wallet will consult its fee model to determine a fee for the default confirmation target.  > 👉 See [https://api.lightning.community/?shell#sendcoins](https://api.lightning.community/?shell#sendcoins)  ### c-lightning: * Set __target_conf__ ==1: interpreted as urgent (aim for next block) * Set __target_conf__ >=2: interpreted as normal (next 4 blocks or so, **default**) * Set __target_cont__ >=10: interpreted as slow (next 100 blocks or so) * If __sat_per_vbyte__ is set then __target_conf__ is ignored and vbytes (sipabytes) will be used.  > 👉 See [https://lightning.readthedocs.io/lightning-txprepare.7.html](https://lightning.readthedocs.io/lightning-txprepare.7.html)  ### Sending all onchain funds > ℹ️ Keep the following points in mind when sending all onchain funds:  * The response object currently will state __\"amount\": 0__ even if __send_all__ is set to __true__ and the transaction was successfully submitted to the mempool. [GitHub issue](https://github.com/fusion44/blitz_api/issues/196) * If __send_all__ is set to __true__, the __amount__ field must be set to __0__. * If the __amount__ field is greater than __0__, the __send_all__ field must be __false__.   * The API will return an error if neither or both conditions are met at the same time. * If __send_all__ is set to __true__ the amount of satoshis to send will be calculated by subtracting the fee from the wallet balance. * If the wallet balance is not sufficient to cover the fee, the call will fail. * The call will __not__ close any channels. * The implementation may keep a reserve of funds if there are still open channels.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();
final SendCoinsInput sendCoinsInput = ; // SendCoinsInput | 

try {
    final response = api.lightningSendCoinsLightningSendCoinsPost(sendCoinsInput);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningSendCoinsLightningSendCoinsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendCoinsInput** | [**SendCoinsInput**](SendCoinsInput.md)|  | 

### Return type

[**SendCoinsResponse**](SendCoinsResponse.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningSendPaymentLightningSendPaymentPost**
> Payment lightningSendPaymentLightningSendPaymentPost(payReq, timeoutSeconds, feeLimitMsat, amountMsat)

Attempt to pay a payment request.

This endpoints attempts to pay a payment request.  Intermediate status updates will be sent via the SSE channel. This endpoint returns the last success or error message from the node.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();
final String payReq = payReq_example; // String | 
final int timeoutSeconds = 56; // int | 
final int feeLimitMsat = 56; // int | 
final int amountMsat = 56; // int | 

try {
    final response = api.lightningSendPaymentLightningSendPaymentPost(payReq, timeoutSeconds, feeLimitMsat, amountMsat);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningSendPaymentLightningSendPaymentPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payReq** | **String**|  | 
 **timeoutSeconds** | **int**|  | [optional] [default to 5]
 **feeLimitMsat** | **int**|  | [optional] [default to 8000]
 **amountMsat** | **int**|  | [optional] 

### Return type

[**Payment**](Payment.md)

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lightningUnlockWalletLightningUnlockWalletPost**
> bool lightningUnlockWalletLightningUnlockWalletPost(unlockWalletInput)

Unlocks a locked wallet.

### Example
```dart
import 'package:blitz_api_client/api.dart';
// TODO Configure HTTP basic authorization: JWTBearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('JWTBearer').password = 'YOUR_PASSWORD';

final api = BlitzApiClient().getLightningApi();
final UnlockWalletInput unlockWalletInput = ; // UnlockWalletInput | 

try {
    final response = api.lightningUnlockWalletLightningUnlockWalletPost(unlockWalletInput);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LightningApi->lightningUnlockWalletLightningUnlockWalletPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **unlockWalletInput** | [**UnlockWalletInput**](UnlockWalletInput.md)|  | 

### Return type

**bool**

### Authorization

[JWTBearer](../README.md#JWTBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

