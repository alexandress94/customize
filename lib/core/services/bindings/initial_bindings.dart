import 'package:get/get.dart';
import 'package:organize_more/core/services/log/log.dart';
import 'package:organize_more/core/services/log/log_implementation.dart';
import 'package:organize_more/core/values/concatenate/concatenate.dart';

import '../packages/contracts/sqlite_expense.dart';
import '../packages/gateways/sqlite_expense_implementation.dart';
import '../packages/gateways/sqlite_connection_implementation.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.putAsync<Log>(
      () => LogImplemetation().getInstance(),
      permanent: true,
    );

    Get.lazyPut<SqliteConnectionImplementation>(
      () => SqliteConnectionImplementation.instance,
    );

    Get.put<SqliteExpense>(SqliteExpenseImplementation(), permanent: true);

    Get.put<Concatenate>(Concatenate(), permanent: true);
  }
}
