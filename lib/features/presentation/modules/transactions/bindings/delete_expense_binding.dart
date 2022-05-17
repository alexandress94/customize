import 'package:get/get.dart';
import 'package:customize/core/services/log/log_implementation.dart';
import 'package:customize/features/data/datasources/delete_all_expense_datasource.dart';
import 'package:customize/features/data/datasources/delete_between_expense_datasource.dart';
import 'package:customize/features/data/datasources/delete_expense_datasource.dart';
import 'package:customize/features/data/repositories/delete_all_expense_repository_implementation.dart';
import 'package:customize/features/data/repositories/delete_between_expense_repository_implementation.dart';
import 'package:customize/features/domain/usecases/delete_all_expense_usecase.dart';
import 'package:customize/features/domain/usecases/delete_between_expense_usecase.dart';
import 'package:customize/features/domain/usecases/delete_expense_usecase.dart';

import '../../../../data/repositories/delete_expense_repository_implementation.dart';
import '../controllers/delete_expense_controller.dart';

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
        deleteAllUsecase: DeleteAllExpenseUsecase(
          repository: DeleteAllExpenseRepositoryImplementation(
            datasource: DeleteAllExpenseDatasourceImplementetion(
              database: Get.find(),
            ),
          ),
        ),
      ),
    );
  }
}
