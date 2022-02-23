import 'package:get/get.dart';
import 'package:organize_more/core/services/log/log_implementation.dart';
import 'package:organize_more/features/data/datasources/insert_expense_datasource.dart';
import 'package:organize_more/features/data/repositories/insert_expense_repository_implementation.dart';
import 'package:organize_more/features/domain/usecases/insert_expense_usecase.dart';
import 'package:organize_more/features/presentation/modules/expense/controllers/insert_expense_controller.dart';

class InsertExpenseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InsertExpenseController>(
      () => InsertExpenseController(
        usecase: InsertExpenseUsecase(
          repository: InsertExpenseRepositoryImplementation(
            datasource: InsertExpenseDatasourceImplementation(
              database: Get.find(),
            ),
          ),
        ),
        log: LogImplemetation(),
      ),
    );
  }
}
