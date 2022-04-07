import 'package:either_dart/either.dart';

abstract class CancelPaymentRepository {
  Future<Either<Exception, int>> cancelPayment({
    required int id,
    required int portion,
  });
}
