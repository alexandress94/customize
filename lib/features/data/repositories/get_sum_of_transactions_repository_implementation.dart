import 'package:customize/features/data/models/amount_model.dart';
import 'package:customize/features/domain/repositories/get_sum_of_transactions_repository.dart';
import 'package:customize/features/data/datasources/get_sum_of_transactions_datasource.dart';
import 'package:customize/core/errors/repository_exception.dart';
import 'package:either_dart/either.dart';

class GetSumOfTransactionsRepositoryImplementation
    implements GetSumOfTransactionsRepository {
  final GetSumOfTransactionsDatasource _datasource;

  GetSumOfTransactionsRepositoryImplementation(
      {required GetSumOfTransactionsDatasource datasource})
      : _datasource = datasource;
  @override
  Future<Either<Exception, List<AmountModel>>> getSum(
      {required DateTime date}) async {
    try {
      final result = await _datasource.getSum(date: date);
      return Right(result);
    } on RepositoryException {
      return Left(RepositoryException.notFound());
    }
  }
}
