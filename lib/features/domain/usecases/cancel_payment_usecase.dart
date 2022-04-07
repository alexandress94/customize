import 'package:organize_more/core/usecases/usecase.dart';
import 'package:organize_more/core/errors/usecase_exception.dart';
import 'package:either_dart/either.dart';

import '../repositories/cancel_payment_repository.dart';

class CancelPaymentUsecase implements Usecase<int, ParameterCancelPayment> {
  final CancelPaymentRepository _repository;

  CancelPaymentUsecase({required CancelPaymentRepository repository})
      : _repository = repository;

  @override
  Future<Either<Exception, int>> call(ParameterCancelPayment parameter) async {
    if (parameter.id < 1 || parameter.portion < 1) {
      return Left(UsecaseException.invalidInput());
    }

    final result = await _repository.cancelPayment(
      id: parameter.id,
      portion: parameter.portion,
    );

    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right);
  }
}

class ParameterCancelPayment {
  final int id;
  final int portion;

  ParameterCancelPayment({
    required this.id,
    required this.portion,
  });
}
