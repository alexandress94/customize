import 'package:customize/core/usecases/usecase.dart';
import 'package:customize/core/errors/usecase_exception.dart';
import 'package:either_dart/either.dart';

import '../repositories/delete_all_expense_repository.dart';

class DeleteAllExpenseUsecase
    implements Usecase<int, ParameterDeleteAllExpense> {
  final DeleteAllExpenseRepository _repository;

  DeleteAllExpenseUsecase({
    required DeleteAllExpenseRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Exception, int>> call(
    ParameterDeleteAllExpense parameter,
  ) async {
    if (parameter.uuId.isEmpty) {
      return Left(UsecaseException.invalidInput());
    }

    final result = await _repository.deleteAll(uuId: parameter.uuId);

    if (result.isLeft) {
      return Left(result.left);
    }

    return Right(result.right);
  }
}

class ParameterDeleteAllExpense {
  final String uuId;

  ParameterDeleteAllExpense({required this.uuId});
}
