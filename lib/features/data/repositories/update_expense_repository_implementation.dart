import 'package:customize/core/errors/repository_exception.dart';
import 'package:either_dart/either.dart';

import '../../domain/repositories/update_expense_repository.dart';
import '../datasources/update_expense_datasource.dart';

class UpdateExpenseRepositoryImplementation implements UpdateExpenseRepository {
  final UpdateExpenseDatasource _datasource;

  UpdateExpenseRepositoryImplementation({
    required UpdateExpenseDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<Exception, int>> updateExpense({
    required Map<String, dynamic> model,
  }) async {
    try {
      final result = await _datasource.updateExpense(model: model);

      return Right(result);
    } on RepositoryException {
      return Left(RepositoryException.notFound());
    }
  }
}
