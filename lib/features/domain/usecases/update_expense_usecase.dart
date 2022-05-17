import 'package:customize/core/usecases/usecase.dart';
import 'package:either_dart/either.dart';

import '../../../core/errors/usecase_exception.dart';
import '../repositories/update_expense_repository.dart';

class UpdateExpenseUsecase implements Usecase<int, ParameterUpdateExpense> {
  final UpdateExpenseRepository _repository;

  UpdateExpenseUsecase({
    required UpdateExpenseRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Exception, int>> call(
    ParameterUpdateExpense parameter,
  ) async {
    if (parameter.uuId.isEmpty ||
        parameter.id < 1 ||
        parameter.description.isEmpty ||
        parameter.date.isEmpty ||
        parameter.value <= 0.0) {
      return Left(UsecaseException.invalidInput());
    }

    final model = {
      "id": parameter.id,
      "uuId": parameter.uuId,
      "ds_transaction": parameter.description,
      "vl_transaction": parameter.value,
      "vl_total": parameter.total,
      "dt_due": parameter.date,
    };

    final result = await _repository.updateExpense(model: model);

    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right);
  }
}

class ParameterUpdateExpense {
  final int id;
  final String uuId;
  final String description;
  final double value;
  final double total;
  final String date;

  ParameterUpdateExpense({
    required this.id,
    required this.uuId,
    required this.description,
    required this.value,
    required this.total,
    required this.date,
  });
}
