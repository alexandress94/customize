import 'package:customize/core/services/log/log_implementation.dart';
import 'package:customize/core/services/packages/gateways/lottie_adapter_implementation.dart';
import 'package:customize/features/data/datasources/get_payment_sum_datasource.dart';
import 'package:customize/features/data/datasources/get_sum_of_expenses_datasource.dart';
import 'package:customize/features/data/datasources/get_sum_of_transactions_datasource.dart';
import 'package:customize/features/data/repositories/get_payment_sum_repository_implementation.dart';
import 'package:customize/features/data/repositories/get_sum_of_expenses_repository_implementation.dart';
import 'package:customize/features/data/repositories/get_sum_of_transactions_repository_implementation.dart';
import 'package:customize/features/domain/usecases/get_payment_usecase.dart';
import 'package:customize/features/domain/usecases/get_sum_of_expenses_usecase.dart';
import 'package:customize/features/domain/usecases/get_sum_of_transactions_usecase.dart';

import 'package:customize/features/data/repositories/get_all_expense_repository_implementation.dart';
import 'package:customize/features/data/datasources/get_all_expense_datasource.dart';
import 'package:customize/features/domain/usecases/get_all_expense_usecase.dart';
import 'package:get/get.dart';

import '../../../../../core/services/packages/contracts/lottie_adapter.dart';
import '../controllers/get_all_expense_controller.dart';

class GetAllExpenseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LottieAdapter>(LottieAdapterImplementation());

    Get.lazyPut<GetAllExpenseController>(
      () => GetAllExpenseController(
        usecaseAllExpense: GetAllExpenseUsecase(
          repository: GetAllExpenseRepositoryImplementation(
            datasource: GetAllExpenseDatasourceImplementation(
              expenseDatabase: Get.find(),
              concatenate: Get.find(),
            ),
          ),
        ),
        usecaseSumOfTransactions: GetSumOfTransactionsUsecase(
          repository: GetSumOfTransactionsRepositoryImplementation(
            datasource: GetSumOfTrasactionsDatasourceImplementetion(
              database: Get.find(),
              concatenate: Get.find(),
            ),
          ),
        ),
        log: LogImplemetation(),
        usecaseSumOfExpenses: GetSumOfExpensesUsecase(
          repository: GetSumOfExpensesRepositoryImplementation(
            datasource: GetSumOfExpensesDatasourceImplementetion(
              database: Get.find(),
              concatenate: Get.find(),
            ),
          ),
        ),
        usecasePaymentSum: GetPaymentSumUsecase(
          repository: GetPaymentSumRepositoryImplementation(
            datasource: GetPaymentSumDatasourceImplementetion(
              database: Get.find(),
              concatenate: Get.find(),
            ),
          ),
        ),
        lottieAdpter: Get.find(),
      ),
    );
  }
}
