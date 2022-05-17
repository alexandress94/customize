import 'package:customize/core/services/log/log.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';

class LogImplemetation extends GetxService implements Log {
  final Logger _logger = Logger();

  List<String> _messages = [];

  Future<Log> getInstance() async {
    info('servico de log iniciado!!!');
    return this;
  }

  @override
  void append(message) {
    _messages.add(message);
  }

  @override
  void closeAppend() {
    info(_messages.join('\n'));
    _messages = [];
  }

  @override
  void debug(message, [error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  @override
  void error(message, [error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }

  @override
  void info(message, [error, StackTrace? stackTrace]) {
    _logger.i(message, error, stackTrace);
  }

  @override
  void warning(message, [error, StackTrace? stackTrace]) {
    _logger.w(message, error, stackTrace);
  }
}
