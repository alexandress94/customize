import 'package:either_dart/either.dart';
import 'package:organize_more/core/errors/repository_exception.dart';
import 'package:organize_more/core/errors/usecase_exception.dart';
import 'package:organize_more/features/data/datasources/insert_expense_datasource.dart';
import 'package:organize_more/features/domain/repositories/insert_expense_repository.dart';

class InsertExpenseRepositoryImplementation implements InsertExpenseRepository {
  final InsertExpenseDatasource _datasource;

  InsertExpenseRepositoryImplementation(
      {required InsertExpenseDatasource datasource})
      : _datasource = datasource;

  @override
  Future<Either<Exception, int>> insertExpense({
    required Map<String, dynamic> expense,
  }) async {
    final result = await _datasource.insertExpense(model: expense);

    try {
      return Right(result);
    } on RepositoryException {
      return Left(RepositoryException.notFound());
    }
  }
}
