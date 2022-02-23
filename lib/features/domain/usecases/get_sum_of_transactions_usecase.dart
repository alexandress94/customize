import 'package:either_dart/either.dart';
import 'package:organize_more/core/errors/usecase_exception.dart';
import 'package:organize_more/core/usecases/usecase.dart';
import 'package:organize_more/features/domain/entities/amount_entity.dart';
import 'package:organize_more/features/domain/repositories/get_sum_of_transactions_repository.dart';

class GetSumOfTransactionsUsecase
    implements Usecase<List<AmountEntity>, ParameterGetSumOfTransactions> {
  final GetSumOfTransactionsRepository _repository;

  GetSumOfTransactionsUsecase({
    required GetSumOfTransactionsRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Exception, List<AmountEntity>>> call(
    ParameterGetSumOfTransactions parameter,
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

class ParameterGetSumOfTransactions {
  final DateTime date;
  ParameterGetSumOfTransactions({required this.date});
}
