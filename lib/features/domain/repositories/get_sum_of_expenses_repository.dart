import 'package:either_dart/either.dart';
import 'package:organize_more/core/errors/usecase_exception.dart';
import 'package:organize_more/features/domain/entities/amount_entity.dart';

abstract class GetSumOfExpensesRepository {
  Future<Either<Exception, List<AmountEntity>>> getSum(
      {required DateTime date});
}
