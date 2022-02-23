import 'package:get/get.dart';
import 'package:organize_more/core/services/log/log.dart';
import 'package:organize_more/core/values/replace/replace_date.dart';
import 'package:organize_more/features/domain/entities/expense_entity.dart';
import 'package:organize_more/features/domain/usecases/get_all_expense_usecase.dart';
import 'package:organize_more/features/domain/usecases/get_sum_of_expenses_usecase.dart';
import 'package:organize_more/features/domain/usecases/get_sum_of_transactions_usecase.dart';
import 'package:organize_more/features/presentation/modules/transaction/controllers/delete_expense_controller.dart';

import '../../../../domain/usecases/get_payment_usecase.dart';
import 'update_payment_controller.dart';

class GetAllExpenseController extends GetxController
    with StateMixin<List<ExpenseEntity>> {
  final updatePaymentController = Get.find<UpdatePaymentController>();
  final deleteExpenseController = Get.find<DeleteExpenseController>();

  final RxList<ExpenseEntity> _allExpenses = <ExpenseEntity>[].obs;
  final GetAllExpenseUsecase _usecaseAllExpense;
  final GetSumOfTransactionsUsecase _usecaseSumOfTransactions;
  final GetSumOfExpensesUsecase _usecaseSumOfExpenses;
  final GetPaymentSumUsecase _usecasePaymentSum;
  final Log _log;

  final Rx<DateTime> _selectedDate = DateTime.now().obs;
  final RxDouble _sumOfTransactions = 0.0.obs;
  final RxDouble _sumOfExpenses = 0.0.obs;
  final RxDouble _paymentSum = 0.0.obs;

  double get getSumOfTransactions => _sumOfTransactions.value;
  double get getSumOfExpenses => _sumOfExpenses.value;
  double get getPaymentSum => _paymentSum.value;

  GetAllExpenseController({
    required GetAllExpenseUsecase usecaseAllExpense,
    required GetSumOfTransactionsUsecase usecaseSumOfTransactions,
    required GetSumOfExpensesUsecase usecaseSumOfExpenses,
    required GetPaymentSumUsecase usecasePaymentSum,
    required Log log,
  })  : _log = log,
        _usecaseAllExpense = usecaseAllExpense,
        _usecaseSumOfExpenses = usecaseSumOfExpenses,
        _usecasePaymentSum = usecasePaymentSum,
        _usecaseSumOfTransactions = usecaseSumOfTransactions;

  @override
  void onInit() {
    find();
    super.onInit();
  }

  void nextFilter() {
    DateTime addMonth = DateTime(
      _selectedDate.value.year,
      _selectedDate.value.month + 1,
    );
    _selectedDate.value = addMonth;
  }

  void backFilter() {
    DateTime subtractMonth = DateTime(
      _selectedDate.value.year,
      _selectedDate.value.month - 1,
    );
    _selectedDate.value = subtractMonth;
  }

  RxString getDescriptionOfFilterSelected() {
    RxString description = "".obs;
    description.value = DescriptionCalendarDate.parameter(
      date: _selectedDate.value,
    );
    return description;
  }

  RxList<ExpenseEntity> get getAllExpenses => _allExpenses;

  Future<void> find() async {
    change([], status: RxStatus.loading());

    final result = await _usecaseAllExpense(
      ParameterGetAllExpense(date: _selectedDate.value),
    );

    _findSumOfTransactions();
    _findSumOfExpenses();
    _findPaymentSum();

    if (result.isRight) {
      _log.debug(result.right);
      _allExpenses.value = result.right;

      _allExpenses.isNotEmpty
          ? change(_allExpenses, status: RxStatus.success())
          : change([], status: RxStatus.empty());
    } else {
      _log.error(result.left);
      change([], status: RxStatus.error());
    }
  }

  Future<void> _findSumOfTransactions() async {
    final result = await _usecaseSumOfTransactions.call(
      ParameterGetSumOfTransactions(
        date: _selectedDate.value,
      ),
    );

    if (result.isLeft) {
      _log.error(result.left);
      return;
    }
    _log.debug(result.right);
    _sumOfTransactions.value = result.right[0].values;
  }

  Future<void> _findSumOfExpenses() async {
    final result = await _usecaseSumOfExpenses.call(
      ParameterGetSumOfExpense(
        date: _selectedDate.value,
      ),
    );

    if (result.isLeft) {
      _log.error(result.left);
      return;
    }
    _log.debug(result.right);
    _sumOfExpenses.value = result.right[0].values;
  }

  Future<void> _findPaymentSum() async {
    final result = await _usecasePaymentSum.call(
      ParameterGetPayment(
        date: _selectedDate.value,
      ),
    );

    if (result.isLeft) {
      _log.error(result.left);
      return;
    }
    _log.debug(result.right);
    _paymentSum.value = result.right[0].values;
  }
}
