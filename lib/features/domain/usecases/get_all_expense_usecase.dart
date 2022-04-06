import 'package:either_dart/either.dart';
import 'package:organize_more/core/errors/usecase_exception.dart';
import 'package:organize_more/core/usecases/usecase.dart';
import 'package:organize_more/features/domain/entities/expense_entity.dart';
import 'package:organize_more/features/domain/repositories/get_all_expense_repository.dart';

class GetAllExpenseUsecase
    implements Usecase<List<ExpenseEntity>, ParameterGetAllExpense> {
  final GetAllExpenseRepository _repository;

  GetAllExpenseUsecase({
    required GetAllExpenseRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Exception, List<ExpenseEntity>>> call(
    ParameterGetAllExpense parameter,
  ) async {
    if (parameter.date.toString().isEmpty) {
      return Left(UsecaseException.invalidInput());
    }

    final result = await _repository.find(date: parameter.date);

    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right);
  }
}

class ParameterGetAllExpense {
  final DateTime date;
  ParameterGetAllExpense({required this.date});
}
