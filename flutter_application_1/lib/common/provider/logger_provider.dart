import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

abstract class LogWriter {
  // Development.
  void debug(dynamic message);

  // Key events.
  void info(dynamic message);

  // Warnings.
  void warn(dynamic message);

  // Error info.
  void error(dynamic message, {StackTrace? stackTrace});

  // WTF! Game over.
  void fatal(dynamic message, {StackTrace? stackTrace});
}

final loggerProvider =
    Provider<PrettyPrintLogWriter>((ref) => PrettyPrintLogWriter());

class PrettyPrintLogWriter implements LogWriter {
  late Logger logger;

  PrettyPrintLogWriter() {
    logger = Logger(
      printer: PrettyPrinter(methodCount: 0),
    );
  }

  @override
  void debug(message) {
    logger.d(message);
  }

  @override
  void error(message, {StackTrace? stackTrace}) {
    logger.e(message, stackTrace);
  }

  @override
  void fatal(message, {StackTrace? stackTrace}) {
    logger.wtf(message, stackTrace);
  }

  @override
  void info(message) {
    logger.i(message);
  }

  @override
  void warn(message) {
    logger.w(message);
  }
}
