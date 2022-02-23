import 'package:organize_more/features/domain/repositories/get_payment_sum_repository.dart';
import 'package:organize_more/features/data/datasources/get_payment_sum_datasource.dart';
import 'package:organize_more/features/data/models/amount_model.dart';
import 'package:organize_more/core/errors/repository_exception.dart';
import 'package:either_dart/either.dart';

class GetPaymentSumRepositoryImplementation implements GetPaymentSumRepository {
  final GetPaymentSumDatasource _datasource;

  GetPaymentSumRepositoryImplementation({
    required GetPaymentSumDatasource datasource,
  }) : _datasource = datasource;
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
