import 'package:organize_more/core/errors/repository_exception.dart';
import 'package:either_dart/either.dart';

import '../../domain/repositories/update_between_expense_repository.dart';
import '../datasources/update_between_expense_datasource.dart';

class UpdateBetweenExpenseRepositoryImplementation
    implements UpdateBetweenExpenseRepository {
  final UpdateBetweenExpenseDatasource _datasource;

  UpdateBetweenExpenseRepositoryImplementation({
    required UpdateBetweenExpenseDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<Exception, int>> updateBetween({
    required Map<String, dynamic> model,
  }) async {
    try {
      final result = await _datasource.updateBetween(model: model);

      return Right(result);
    } on RepositoryException {
      return Left(RepositoryException.notFound());
    }
  }
}
