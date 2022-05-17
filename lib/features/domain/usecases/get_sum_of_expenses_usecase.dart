import 'package:either_dart/either.dart';
import 'package:customize/core/errors/usecase_exception.dart';
import 'package:customize/core/usecases/usecase.dart';
import 'package:customize/features/domain/entities/amount_entity.dart';
import 'package:customize/features/domain/repositories/get_sum_of_expenses_repository.dart';

class GetSumOfExpensesUsecase
    implements Usecase<List<AmountEntity>, ParameterGetSumOfExpense> {
  final GetSumOfExpensesRepository _repository;

  GetSumOfExpensesUsecase({
    required GetSumOfExpensesRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Exception, List<AmountEntity>>> call(
    ParameterGetSumOfExpense parameter,
  ) async {
    if (parameter.date.toString().isEmpty) {
      return Left(UsecaseException.invalidInput());
    }

    final result = await _repository.getSum(date: parameter.date);

    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right);
  }
}

class ParameterGetSumOfExpense {
  final DateTime date;
  ParameterGetSumOfExpense({required this.date});
}
