import 'package:customize/core/usecases/usecase.dart';
import 'package:customize/core/errors/usecase_exception.dart';
import 'package:either_dart/either.dart';

import '../repositories/delete_between_expense_repository.dart';

class DeleteBetweenExpenseUsecase
    implements Usecase<int, ParameterDeleteBetweenExpense> {
  final DeleteBetweenExpenseRepository _repository;

  DeleteBetweenExpenseUsecase({
    required DeleteBetweenExpenseRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Exception, int>> call(
    ParameterDeleteBetweenExpense parameter,
  ) async {
    if (parameter.model.isEmpty) {
      return Left(UsecaseException.invalidInput());
    }

    final result = await _repository.deleteBetween(model: parameter.model);

    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right);
  }
}

class ParameterDeleteBetweenExpense {
  final Map<String, dynamic> model;

  ParameterDeleteBetweenExpense({required this.model});
}
