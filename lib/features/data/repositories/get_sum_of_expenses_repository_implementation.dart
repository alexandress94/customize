import 'package:customize/features/domain/repositories/get_sum_of_expenses_repository.dart';
import 'package:customize/features/data/datasources/get_sum_of_expenses_datasource.dart';
import 'package:customize/features/data/models/amount_model.dart';
import 'package:customize/core/errors/repository_exception.dart';
import 'package:either_dart/either.dart';

class GetSumOfExpensesRepositoryImplementation
    implements GetSumOfExpensesRepository {
  final GetSumOfExpensesDatasource _datasource;

  GetSumOfExpensesRepositoryImplementation(
      {required GetSumOfExpensesDatasource datasource})
      : _datasource = datasource;
  @override
  Future<Either<Exception, List<AmountModel>>> getSum({
    required DateTime date,
  }) async {
    try {
      final result = await _datasource.getSum(date: date);

      return Right(result);
    } on RepositoryException {
      return Left(RepositoryException.notFound());
    }
  }
}
