part of 'subscription_repository.dart';

class UnknownSseTypeException implements Exception {
  final String message;

  UnknownSseTypeException(this.message);

  static UnknownSseTypeException withDefaultMessage(String? sseType) =>
      UnknownSseTypeException('Found an unknown SSE type $sseType');
}
