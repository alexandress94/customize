import 'package:organize_more/features/domain/repositories/update_payment_repository.dart';
import 'package:organize_more/core/usecases/usecase.dart';
import 'package:organize_more/core/errors/usecase_exception.dart';
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
