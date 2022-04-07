import 'package:get/get.dart';
import 'package:organize_more/core/services/log/log.dart';

import '../../../../domain/usecases/cancel_payment_usecase.dart';
import '../../../routes/routes.dart';
import '../../../utils/loader_mixin.dart';
import '../../../utils/message_mixin.dart';

class CancelPaymentController extends GetxController
    with LoaderMixin, MessageMixin {
  final CancelPaymentUsecase _usecase;
  final Log _log;

  final message = Rxn<MessageModel>();
  RxBool isLoading = false.obs;

  CancelPaymentController({
    required CancelPaymentUsecase usecase,
    required Log log,
  })  : _usecase = usecase,
        _log = log;

  @override
  onInit() {
    super.onInit();
    messageListener(message);
  }

  Future<void> cancelPayment({
    required int id,
    required int portion,
  }) async {
    isLoading.value = true;
    final result = await _usecase(
      ParameterCancelPayment(
        id: id,
        portion: portion,
      ),
    );

    isLoading.value = false;

    if (result.isLeft) {
      _log.error(result.left);
      Get.offAllNamed(Routes.ERROR_PAGE);
      message(MessageModel.error('Falha', result.left.toString()));
      return;
    }

    _log.debug(result.right);
    message(MessageModel.sucess('Sucesso', 'Pagamento cancelado!'));
  }
}
