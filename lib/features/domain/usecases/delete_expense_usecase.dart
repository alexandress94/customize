import 'package:customize/core/usecases/usecase.dart';
import 'package:customize/core/errors/usecase_exception.dart';
import 'package:either_dart/either.dart';

import '../repositories/delete_expense_repository.dart';

class DeleteExpenseUsecase implements Usecase<int, ParameterDeleteExpense> {
  final DeleteExpenseRepository _repository;

  DeleteExpenseUsecase({required DeleteExpenseRepository repository})
      : _repository = repository;

  @override
  Future<Either<Exception, int>> call(ParameterDeleteExpense parameter) async {
    if (parameter.id < 1) {
      return Left(UsecaseException.invalidInput());
    }

    final result = await _repository.delete(id: parameter.id);

    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right);
  }
}

class ParameterDeleteExpense {
  final int id;

  ParameterDeleteExpense({required this.id});
}
