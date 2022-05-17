import 'package:customize/core/usecases/usecase.dart';
import 'package:customize/core/errors/usecase_exception.dart';
import 'package:customize/features/domain/repositories/update_all_expense_repository.dart';
import 'package:either_dart/either.dart';

class UpdateAllExpenseUsecase
    implements Usecase<int, ParameterUpdateAllExpense> {
  final UpdateAllExpenseRepository _repository;

  UpdateAllExpenseUsecase({
    required UpdateAllExpenseRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Exception, int>> call(
    ParameterUpdateAllExpense parameter,
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
    final result = await _repository.updateAll(model: model);

    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right);
  }
}

class ParameterUpdateAllExpense {
  final int id;
  final String uuId;
  final String description;
  final double value;
  final double total;
  final String date;

  ParameterUpdateAllExpense({
    required this.id,
    required this.uuId,
    required this.description,
    required this.value,
    required this.total,
    required this.date,
  });
}
