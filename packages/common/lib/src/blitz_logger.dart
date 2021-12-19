import 'package:logger/logger.dart';

enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
  wtf,
  nothing,
}

Level _translateLogLevel(LogLevel l) => Level.values[l.index];

class BlitzLog {
  static LogLevel level = LogLevel.verbose;
  static final BlitzLog _singleton = BlitzLog._internal();
  late final Logger _logger;

  factory BlitzLog() {
    return _singleton;
  }

  BlitzLog._internal() {
    Logger.level = _translateLogLevel(level);
    _logger = Logger(printer: PrettyPrinter());
  }

  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.d(message, error, stackTrace);

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error, stackTrace);

  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.i(message, error, stackTrace);

  void log(Level level, dynamic message,
          [dynamic error, StackTrace? stackTrace]) =>
      _logger.log(level, message, error, stackTrace);

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
