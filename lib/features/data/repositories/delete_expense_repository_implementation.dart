import 'package:customize/core/errors/repository_exception.dart';
import 'package:either_dart/either.dart';

import '../../domain/repositories/delete_expense_repository.dart';
import '../datasources/delete_expense_datasource.dart';

class DeleteExpenseRepositoryImplementation implements DeleteExpenseRepository {
  final DeleteExpenseDatasource _datasource;

  DeleteExpenseRepositoryImplementation({
    required DeleteExpenseDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<Exception, int>> delete({required int id}) async {
    try {
      final result = await _datasource.delete(id: id);

      return Right(result);
    } on RepositoryException {
      return Left(RepositoryException.notFound());
    }
  }
}
