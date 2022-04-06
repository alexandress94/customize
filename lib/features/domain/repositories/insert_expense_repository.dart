import 'package:either_dart/either.dart';

abstract class InsertExpenseRepository {
  Future<Either<Exception, int>> insertExpense({
    required Map<String, dynamic> expense,
  });
}
