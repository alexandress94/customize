import 'package:either_dart/either.dart';

abstract class UpdatePaymentRepository {
  Future<Either<Exception, int>> updatePayment({
    required int id,
    required int portion,
  });
}
