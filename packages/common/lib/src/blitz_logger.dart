import 'package:logger/logger.dart';

class BlitzLog {
  static final BlitzLog _singleton = BlitzLog._internal();
  late final Logger _logger;

  factory BlitzLog() {
    return _singleton;
  }

  BlitzLog._internal() {
    _logger = Logger(printer: PrettyPrinter());
  }

  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.d(message, error, stackTrace);

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error, stackTrace);

  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.i(message, error, stackTrace);

  void log(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.log(message, error, stackTrace);

  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.v(message, error, stackTrace);

  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.w(message, error, stackTrace);

  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.wtf(message, error, stackTrace);

  void close() {
    _logger.i('Closing logger.');
    _logger.close();
  }
}
