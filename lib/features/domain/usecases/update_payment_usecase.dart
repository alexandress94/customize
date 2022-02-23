import 'package:organize_more/features/domain/repositories/update_payment_repository.dart';
import 'package:organize_more/core/usecases/usecase.dart';
import 'package:organize_more/core/errors/usecase_exception.dart';
import 'package:either_dart/either.dart';

class UpdatePaymentUsecase implements Usecase<int, ParameterUpdatePayment> {
  final UpdatePaymentRepository _repository;

  UpdatePaymentUsecase({required UpdatePaymentRepository repository})
      : _repository = repository;

  @override
  Future<Either<Exception, int>> call(ParameterUpdatePayment parameter) async {
    if (parameter.id < 1 || parameter.portion < 1) {
      return Left(UsecaseException.invalidInput());
    }

    final result = await _repository.updateExpense(
      id: parameter.id,
      portion: parameter.portion,
    );

    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right);
  }
}

class ParameterUpdatePayment {
  final int id;
  final int portion;

  ParameterUpdatePayment({
    required this.id,
    required this.portion,
  });
}
