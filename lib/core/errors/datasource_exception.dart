class DatasourceException implements Exception {
  final String _message;

  const DatasourceException({required String message}) : _message = message;

  factory DatasourceException.badRequest([String value = '']) {
    return DatasourceException(message: 'Falha na requisição. $value');
  }

  @override
  String toString() {
    return _message;
  }
}
