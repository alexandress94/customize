import 'package:customize/core/errors/repository_exception.dart';
import 'package:either_dart/either.dart';

import '../../domain/repositories/delete_all_expense_repository.dart';
import '../datasources/delete_all_expense_datasource.dart';

class DeleteAllExpenseRepositoryImplementation
    implements DeleteAllExpenseRepository {
  final DeleteAllExpenseDatasource _datasource;

  DeleteAllExpenseRepositoryImplementation({
    required DeleteAllExpenseDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<Exception, int>> deleteAll({required String uuId}) async {
    try {
      final result = await _datasource.deleteAll(uuId: uuId);

      return Right(result);
    } on RepositoryException {
      return Left(RepositoryException.notFound());
    }
  }
}
