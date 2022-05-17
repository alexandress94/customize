import 'package:either_dart/either.dart';
import 'package:customize/features/domain/entities/expense_entity.dart';

abstract class GetAllExpenseRepository {
  Future<Either<Exception, List<ExpenseEntity>>> find({
    required DateTime date,
  });
}
