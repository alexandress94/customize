import 'package:organize_more/features/domain/repositories/insert_expense_repository.dart';
import 'package:organize_more/core/errors/usecase_exception.dart';
import 'package:organize_more/core/usecases/usecase.dart';
import 'package:either_dart/either.dart';

class InsertExpenseUsecase implements Usecase<int, ParameterInsertExpense> {
  final InsertExpenseRepository _repository;

  InsertExpenseUsecase({required InsertExpenseRepository repository})
      : _repository = repository;

  @override
  Future<Either<Exception, int>> call(ParameterInsertExpense parameter) async {
    if (parameter.expenses.isEmpty) {
      return Left(UsecaseException.invalidInput());
    }

    if (parameter.expenses['nr_installment'] as int > 99) {
      return Left(UsecaseException.invalidInput());
    }

    final result = await _repository.insertExpense(expense: parameter.expenses);

    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right);
  }
}

class ParameterInsertExpense {
  Map<String, dynamic> expenses;

  ParameterInsertExpense({
    required this.expenses,
  });
}
