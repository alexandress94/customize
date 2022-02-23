class UsecaseException implements Exception {
  final String _message;

  UsecaseException({required String message}) : _message = message;

  factory UsecaseException.invalidInput({
    String error = '',
    String value = '',
  }) {
    return UsecaseException(
      message:
          error.isEmpty ? 'Parâmetro inválido. $value' : error + ' ' + value,
    );
  }

  @override
  String toString() {
    return _message;
  }
}
