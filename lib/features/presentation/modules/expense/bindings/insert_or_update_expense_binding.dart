import 'package:get/get.dart';
import 'package:organize_more/core/services/log/log_implementation.dart';
import 'package:organize_more/features/data/datasources/insert_expense_datasource.dart';
import 'package:organize_more/features/data/datasources/update_between_expense_datasource.dart';
import 'package:organize_more/features/data/repositories/insert_expense_repository_implementation.dart';
import 'package:organize_more/features/data/repositories/update_between_expense_repository_implementation.dart';
import 'package:organize_more/features/domain/usecases/insert_expense_usecase.dart';

import '../../../../data/datasources/update_expense_datasource.dart';
import '../../../../data/repositories/update_expense_repository_implementation.dart';
import '../../../../domain/usecases/update_between_expense_usecase.dart';
import '../../../../domain/usecases/update_expense_usecase.dart';
import '../controllers/insert_or_update_expense_controller.dart';

class InsertUpdateExpenseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InsertOrUpdateExpenseController>(
      InsertOrUpdateExpenseController(
        insertExpenseUsecase: InsertExpenseUsecase(
          repository: InsertExpenseRepositoryImplementation(
            datasource: InsertExpenseDatasourceImplementation(
              database: Get.find(),
            ),
          ),
        ),
        log: LogImplemetation(),
        updateExpenseUsecase: UpdateExpenseUsecase(
          repository: UpdateExpenseRepositoryImplementation(
            datasource: UpdateExpenseDatasourceImplementetion(
              database: Get.find(),
            ),
          ),
        ),
        arguments: Get.arguments,
        updateBetweenExpenseUsecase: UpdateBetweenExpenseUsecase(
          repository: UpdateBetweenExpenseRepositoryImplementation(
            datasource: UpdateBetweenExpenseDatasourceImplementetion(
              database: Get.find(),
            ),
          ),
        ),
      ),
    );
  }
}
