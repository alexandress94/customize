import 'package:customize/core/errors/repository_exception.dart';
import 'package:customize/features/data/datasources/update_all_expense_datasource.dart';
import 'package:customize/features/domain/repositories/update_all_expense_repository.dart';
import 'package:either_dart/either.dart';

class UpdateAllExpenseRepositoryImplementation
    implements UpdateAllExpenseRepository {
  final UpdateAllExpenseDatasource _datasource;

  UpdateAllExpenseRepositoryImplementation({
    required UpdateAllExpenseDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<Exception, int>> updateAll({
    required Map<String, dynamic> model,
  }) async {
    try {
      final result = await _datasource.updateAll(model: model);

      return Right(result);
    } on RepositoryException {
      return Left(RepositoryException.notFound());
    }
  }
}
