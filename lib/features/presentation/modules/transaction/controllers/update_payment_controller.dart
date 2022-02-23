import 'package:get/get.dart';
import 'package:organize_more/core/services/log/log.dart';
import 'package:organize_more/features/domain/usecases/update_payment_usecase.dart';
import 'package:organize_more/features/presentation/utils/show_snackbar.dart';

class UpdatePaymentController extends GetxController {
  final UpdatePaymentUsecase _usecase;
  final Log _log;

  UpdatePaymentController({
    required UpdatePaymentUsecase usecase,
    required Log log,
  })  : _usecase = usecase,
        _log = log;

  Future<void> updateExpense({
    required int id,
    required int portion,
  }) async {
    final result = await _usecase(
      ParameterUpdatePayment(
        id: id,
        portion: portion,
      ),
    );

    if (result.isLeft) {
      _log.error(result.left);
      showSnackBar(
        resopnse: StatusNotification.ERROR,
        message: result.left.toString(),
      );
      return;
    }

    _log.debug(result.right);
    showSnackBar(
      resopnse: StatusNotification.SUCCESS,
      message: 'Pagamento atualizado!',
    );
  }
}
