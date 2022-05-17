import 'package:customize/features/domain/repositories/get_all_expense_repository.dart';
import 'package:customize/features/data/datasources/get_all_expense_datasource.dart';
import 'package:customize/features/domain/entities/expense_entity.dart';
import 'package:customize/core/errors/repository_exception.dart';
import 'package:either_dart/either.dart';

class GetAllExpenseRepositoryImplementation implements GetAllExpenseRepository {
  final GetAllExpenseDatasource _datasource;

  GetAllExpenseRepositoryImplementation({
    required GetAllExpenseDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<Exception, List<ExpenseEntity>>> find({
    required DateTime date,
  }) async {
    try {
      final result = await _datasource.find(date: date);
      return Right(result);
    } on RepositoryException {
      return Left(RepositoryException.notFound());
    }
  }
}
