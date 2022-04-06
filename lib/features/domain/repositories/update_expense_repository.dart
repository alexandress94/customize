import 'package:either_dart/either.dart';

abstract class UpdateExpenseRepository {
  Future<Either<Exception, int>> updateExpense({
    required Map<String, dynamic> model,
  });
}
