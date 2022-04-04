import 'package:get/get.dart';

import 'package:organize_more/features/presentation/modules/expense/expense_page.dart';

import 'package:organize_more/features/presentation/routes/routes.dart';

import '../modules/transactions/bindings/delete_expense_binding.dart';
import '../modules/transactions/bindings/get_all_expense_binding.dart';
import '../modules/transactions/bindings/insert_expense_binding.dart';
import '../modules/transactions/bindings/update_payment_binding.dart';
import '../modules/transactions/transactions_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.INITIAL_PAGE,
      page: () => const TransactionsPage(),
      bindings: [
        GetAllExpenseBinding(),
        InsertExpenseBinding(),
        UpdatePaymentBinding(),
        DeleteExpenseBinding(),
      ],
    ),
    GetPage(
      name: Routes.EXPANSE_PAGE,
      page: () => const ExpansePage(),
      binding: InsertExpenseBinding(),
    ),
  ];
}
