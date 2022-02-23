class RepositoryException implements Exception {
  final String _message;

  const RepositoryException({required String message}) : _message = message;

  factory RepositoryException.notFound([String value = '']) {
    return RepositoryException(message: 'Não encontrado. $value');
  }

  @override
  String toString() {
    return _message;
  }
}
