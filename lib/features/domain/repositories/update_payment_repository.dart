import 'package:either_dart/either.dart';

abstract class UpdatePaymentRepository {
  Future<Either<Exception, int>> updateExpense({
    required int id,
    required int portion,
  });
}
