import 'package:organize_more/core/errors/repository_exception.dart';
import 'package:either_dart/either.dart';

import '../../domain/repositories/cancel_payment_repository.dart';
import '../datasources/cancel_payment_datasource.dart';

class CancelPaymentRepositoryImplementation implements CancelPaymentRepository {
  final CancelPaymentDatasource _datasource;

  CancelPaymentRepositoryImplementation({
    required CancelPaymentDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<Exception, int>> cancelPayment({
    required int id,
    required int portion,
  }) async {
    try {
      final result = await _datasource.cancelPayment(
        id: id,
        portion: portion,
      );

      return Right(result);
    } on RepositoryException {
      return Left(RepositoryException.notFound());
    }
  }
}
