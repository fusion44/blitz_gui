import 'package:dio/dio.dart';

class ApiError extends Error {
  final int statusCode;
  final String statusMessage;
  final String message;
  final String detail;

  ApiError(this.statusCode, this.statusMessage, this.message, this.detail);

  factory ApiError.fromDioError(DioError e) {
    String detail = '';
    final res = e.response;
    try {
      if (res != null && res.data is Map) {
        detail = res.data['detail'] as String;
      }
    } catch (e) {
      print(e);
    }

    return ApiError(
      e.response?.statusCode ?? -1,
      e.response?.statusMessage ?? '',
      e.message,
      detail,
    );
  }

  factory ApiError.unknown({
    int statusCode = -1,
    String statusMessage = 'Internal Error',
    String message = 'Unknown error',
    String detail = 'Something bad happened but we don\'t know what.',
  }) =>
      ApiError(
        statusCode,
        statusMessage,
        message,
        detail,
      );
}
