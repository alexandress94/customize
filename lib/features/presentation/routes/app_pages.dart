import 'package:get/get.dart';
import 'package:organize_more/features/presentation/modules/transaction/bindings/insert_expense_binding.dart';
import 'package:organize_more/features/presentation/modules/expense/expense_page.dart';
import 'package:organize_more/features/presentation/modules/transaction/bindings/get_all_expense_binding.dart';
import 'package:organize_more/features/presentation/modules/transaction/bindings/update_payment_binding.dart';
import 'package:organize_more/features/presentation/modules/transaction/transaction_page.dart';
import 'package:organize_more/features/presentation/routes/routes.dart';

import '../modules/transaction/bindings/delete_expense_binding.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.INITIAL_PAGE, page: () => const TransactionPage(),
      // binding: GetAllExpenseBinding(),
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
