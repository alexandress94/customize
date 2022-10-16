import 'package:customize/core/services/local_notification/local_notification_service.dart';
import 'package:get/get.dart';
import 'package:customize/core/services/log/log.dart';
import 'package:customize/features/domain/usecases/update_payment_usecase.dart';

import '../../../routes/routes.dart';
import '../../../utils/loader_mixin.dart';
import '../../../utils/message_mixin.dart';

class UpdatePaymentController extends GetxController
    with LoaderMixin, MessageMixin {
  final UpdatePaymentUsecase _usecase;
  final Log _log;
  final _notificationSerivce = Get.find<LocalNotificationService>();

  final message = Rxn<MessageModel>();
  RxBool isLoading = false.obs;

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

  Future<void> updatePayment({
    required int id,
    required int portion,
  }) async {
    isLoading.value = true;
    final result = await _usecase(
      ParameterUpdatePayment(
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

    await _notificationSerivce.cancelNotifications(id);
    _log.debug(result.right);
    message(MessageModel.sucess('Sucesso', 'Pagamento finalizado!'));
  }
}
