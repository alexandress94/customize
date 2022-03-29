import 'package:organize_more/core/errors/repository_exception.dart';
import 'package:either_dart/either.dart';

import '../../domain/repositories/delete_between_expense_repository.dart';

import '../datasources/delete_between_expense_datasource.dart';

class DeleteBetweenExpenseRepositoryImplementation
    implements DeleteBetweenExpenseRepository {
  final DeleteBetweenExpenseDatasource _datasource;

  DeleteBetweenExpenseRepositoryImplementation({
    required DeleteBetweenExpenseDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<Exception, int>> deleteBetween({
    required Map<String, dynamic> model,
  }) async {
    try {
      final result = await _datasource.deleteBetween(model: model);

      return Right(result);
    } on RepositoryException {
      return Left(RepositoryException.notFound());
    }
  }
}
