import 'package:organize_more/core/usecases/usecase.dart';
import 'package:organize_more/core/errors/usecase_exception.dart';
import 'package:either_dart/either.dart';

import '../repositories/update_between_expense_repository.dart';

class UpdateBetweenExpenseUsecase
    implements Usecase<int, ParameterUpdateBetweenExpense> {
  final UpdateBetweenExpenseRepository _repository;

  UpdateBetweenExpenseUsecase({
    required UpdateBetweenExpenseRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Exception, int>> call(
    ParameterUpdateBetweenExpense parameter,
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
    final result = await _repository.updateBetween(model: model);

    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right);
  }
}

class ParameterUpdateBetweenExpense {
  final int id;
  final String uuId;
  final String description;
  final double value;
  final double total;
  final String date;

  ParameterUpdateBetweenExpense({
    required this.id,
    required this.uuId,
    required this.description,
    required this.value,
    required this.total,
    required this.date,
  });
}
