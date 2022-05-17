import 'package:customize/features/domain/repositories/update_payment_repository.dart';
import 'package:customize/features/data/datasources/update_payment_datasource.dart';
import 'package:customize/core/errors/repository_exception.dart';
import 'package:either_dart/either.dart';

class UpdatePaymentRepositoryImplementation implements UpdatePaymentRepository {
  final UpdatePaymentDatasource _datasource;

  UpdatePaymentRepositoryImplementation({
    required UpdatePaymentDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<Exception, int>> updatePayment({
    required int id,
    required int portion,
  }) async {
    try {
      final result = await _datasource.updatePayment(
        id: id,
        portion: portion,
      );

      return Right(result);
    } on RepositoryException {
      return Left(RepositoryException.notFound());
    }
  }
}
