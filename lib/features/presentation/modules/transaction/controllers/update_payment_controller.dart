import 'package:get/get.dart';
import 'package:organize_more/core/services/log/log.dart';
import 'package:organize_more/features/domain/usecases/update_payment_usecase.dart';

import '../../../utils/loader_mixin.dart';
import '../../../utils/message_mixin.dart';

class UpdatePaymentController extends GetxController
    with LoaderMixin, MessageMixin {
  final UpdatePaymentUsecase _usecase;
  final Log _log;

  final message = Rxn<MessageModel>();

  UpdatePaymentController({
    required UpdatePaymentUsecase usecase,
    required Log log,
  })  : _usecase = usecase,
        _log = log;

  @override
  onInit() {
    super.onInit();
    messageListener(message);
  }

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
      message(MessageModel.error('Falha', result.left.toString()));
      return;
    }

    _log.debug(result.right);
    message(MessageModel.sucess('Sucesso', 'Pagamento finalizado!'));
  }
}
