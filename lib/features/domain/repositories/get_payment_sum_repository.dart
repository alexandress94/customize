import 'package:either_dart/either.dart';
import 'package:customize/features/domain/entities/amount_entity.dart';

abstract class GetPaymentSumRepository {
  Future<Either<Exception, List<AmountEntity>>> getSum(
      {required DateTime date});
}
