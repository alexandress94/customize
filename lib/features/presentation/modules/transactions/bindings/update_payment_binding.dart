import 'package:get/get.dart';
import 'package:organize_more/features/data/datasources/update_payment_datasource.dart';
import 'package:organize_more/features/data/repositories/update_payment_repository_implementation.dart';
import 'package:organize_more/features/domain/usecases/update_payment_usecase.dart';

import '../../../../../core/services/log/log_implementation.dart';
import '../controllers/update_payment_controller.dart';

class UpdatePaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UpdatePaymentController>(
      UpdatePaymentController(
        log: LogImplemetation(),
        usecase: UpdatePaymentUsecase(
          repository: UpdatePaymentRepositoryImplementation(
            datasource: UpdatePaymentDatasourceImplementetion(
              database: Get.find(),
            ),
          ),
        ),
      ),
    );
  }
}
