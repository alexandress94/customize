import 'package:get/get.dart';

import '../../../../../core/services/log/log_implementation.dart';
import '../../../../data/datasources/cancel_payment_datasource.dart';
import '../../../../data/repositories/cancel_payment_repository_implementation.dart';
import '../../../../domain/usecases/cancel_payment_usecase.dart';
import '../controllers/cancel_payment_controller.dart';

class CancelPaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CancelPaymentController>(
      CancelPaymentController(
        log: LogImplemetation(),
        usecase: CancelPaymentUsecase(
          repository: CancelPaymentRepositoryImplementation(
            datasource: CancelPaymentDatasourceImplementetion(
              database: Get.find(),
            ),
          ),
        ),
      ),
    );
  }
}
