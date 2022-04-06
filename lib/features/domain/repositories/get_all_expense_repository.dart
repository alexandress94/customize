import 'package:either_dart/either.dart';
import 'package:organize_more/features/domain/entities/expense_entity.dart';

abstract class GetAllExpenseRepository {
  Future<Either<Exception, List<ExpenseEntity>>> find({
    required DateTime date,
  });
}
