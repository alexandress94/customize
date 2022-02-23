import 'package:either_dart/either.dart';
import 'package:organize_more/core/errors/usecase_exception.dart';

class ValidateParameterUsecase {
  ValidateParameterUsecase._instance();

  static Left? validateInput(dynamic value) {
    if (value.runtimeType == String) {
      String input = value;
      if (input.isEmpty) {
        return Left(
          UsecaseException.invalidInput(error: 'Texto não pode ser vazio.'),
        );
      }
    } else if (value.runtimeType == int) {
      int input = value;
      if (input < 1) {
        return Left(
          UsecaseException.invalidInput(error: 'Número inválido.'),
        );
      }
    } else if (value.runtimeType == double) {
      double input = value;
      if (input < 0.0) {
        return Left(UsecaseException.invalidInput(error: 'Valor inválido.'));
      }
    } else if (value.runtimeType == Map) {
      Map input = value;
      if (input.isEmpty) {
        return Left(
          UsecaseException.invalidInput(error: 'Parâmetro não pode ser vazio.'),
        );
      }
    } else if (value.runtimeType == DateTime) {
      DateTime input = value;
      if (input.toString().isEmpty) {
        return Left(UsecaseException.invalidInput(error: 'Data inválida.'));
      }
    } else if (value.runtimeType == dynamic) {
      dynamic input = value;
      if (input.toString().isEmpty) {
        return Left(
            UsecaseException.invalidInput(error: 'Parâmetro inválida.'));
      }
      return null;
    }
  }
}
