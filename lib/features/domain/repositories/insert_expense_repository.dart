import 'package:either_dart/either.dart';
import 'package:organize_more/core/errors/usecase_exception.dart';

abstract class InsertExpenseRepository {
  Future<Either<Exception, int>> insertExpense({
    required Map<String, dynamic> expense,
  });
}
