import 'package:organize_more/features/domain/repositories/update_payment_repository.dart';
import 'package:organize_more/features/data/datasources/update_payment_datasource.dart';
import 'package:organize_more/core/errors/repository_exception.dart';
import 'package:either_dart/either.dart';

class UpdatePaymentRepositoryImplementation implements UpdatePaymentRepository {
  final UpdatePaymentDatasource _datasource;

  UpdatePaymentRepositoryImplementation({
    required UpdatePaymentDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<Exception, int>> updateExpense({
    required int id,
    required int portion,
  }) async {
    try {
      final result = await _datasource.updateExpense(
        id: id,
        portion: portion,
      );

      return Right(result);
    } on RepositoryException {
      return Left(RepositoryException.notFound());
    }
  }
}
