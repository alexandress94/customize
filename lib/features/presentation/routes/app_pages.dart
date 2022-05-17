import 'package:get/get.dart';

import 'package:customize/features/presentation/modules/expense/expense_page.dart';
import 'package:customize/features/presentation/modules/on_error/bindings/on_error_binding.dart';
import 'package:customize/features/presentation/modules/onboarding/binding/onboarding_binding.dart';
import 'package:customize/features/presentation/modules/onboarding/onboarding_page.dart';
import 'package:customize/features/presentation/modules/settings/binding/settings_binding.dart';
import 'package:customize/features/presentation/modules/splash/splash_page.dart';

import 'package:customize/features/presentation/routes/routes.dart';

import '../modules/on_error/on_error_page.dart';
import '../modules/settings/settings_page.dart';
import '../modules/expense/bindings/insert_or_update_expense_binding.dart';
import '../modules/splash/binding/splash_binding.dart';
import '../modules/transactions/bindings/cancel_payment_binding.dart';
import '../modules/transactions/bindings/delete_expense_binding.dart';
import '../modules/transactions/bindings/get_all_expense_binding.dart';
import '../modules/transactions/bindings/update_payment_binding.dart';
import '../modules/transactions/transactions_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.INITIAL_PAGE,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING_PAGE,
      page: () => OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.TRANSACTION_PAGE,
      page: () => const TransactionsPage(),
      bindings: [
        GetAllExpenseBinding(),
        UpdatePaymentBinding(),
        CancelPaymentBinding(),
        DeleteExpenseBinding(),
      ],
    ),
    GetPage(
      name: Routes.EXPANSE_PAGE,
      page: () => const ExpansePage(),
      binding: InsertUpdateExpenseBinding(),
    ),
    GetPage(
      name: Routes.ERROR_PAGE,
      page: () => const OnErrorPage(),
      binding: OnErrorBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS_PAGE,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
    ),
  ];
}
