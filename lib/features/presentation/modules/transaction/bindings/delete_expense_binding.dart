import 'package:get/get.dart';
import 'package:organize_more/core/services/log/log_implementation.dart';
import 'package:organize_more/features/data/datasources/delete_between_expense_datasource.dart';
import 'package:organize_more/features/data/datasources/delete_expense_datasource.dart';
import 'package:organize_more/features/data/repositories/delete_between_expense_repository_implementation.dart';
import 'package:organize_more/features/domain/usecases/delete_between_expense_usecase.dart';
import 'package:organize_more/features/domain/usecases/delete_expense_usecase.dart';
import 'package:organize_more/features/presentation/modules/transaction/controllers/delete_expense_controller.dart';

import '../../../../data/repositories/delete_expense_repository_implementation.dart';

class DeleteExpenseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      DeleteExpenseController(
        deleteUsecase: DeleteExpenseUsecase(
          repository: DeleteExpenseRepositoryImplementation(
            datasource: DeleteExpenseDatasourceImplementetion(
              database: Get.find(),
            ),
          ),
        ),
        log: LogImplemetation(),
        deleteBetweenUsecase: DeleteBetweenExpenseUsecase(
          repository: DeleteBetweenExpenseRepositoryImplementation(
            datasource: DeleteBetweenExpenseDatasourceImplementetion(
              database: Get.find(),
            ),
          ),
        ),
      ),
    );
  }
}
