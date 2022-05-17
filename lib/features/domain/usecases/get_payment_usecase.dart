import 'package:customize/features/domain/repositories/get_payment_sum_repository.dart';
import 'package:customize/features/domain/entities/amount_entity.dart';
import 'package:customize/core/usecases/usecase.dart';
import 'package:customize/core/errors/usecase_exception.dart';
import 'package:either_dart/either.dart';

class GetPaymentSumUsecase
    implements Usecase<List<AmountEntity>, ParameterGetPayment> {
  final GetPaymentSumRepository _repository;

  GetPaymentSumUsecase({
    required GetPaymentSumRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Exception, List<AmountEntity>>> call(
    ParameterGetPayment parameter,
  ) async {
    if (parameter.date.toString().isEmpty) {
      return Left(UsecaseException.invalidInput());
    }

    final result = await _repository.getSum(date: parameter.date);

    if (result.isLeft) {
      return Left(result.left);
    }
    return Right(result.right);
  }
}

class ParameterGetPayment {
  final DateTime date;
  ParameterGetPayment({required this.date});
}
