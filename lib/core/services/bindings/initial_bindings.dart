import 'package:get/get.dart';
import 'package:customize/core/services/log/log.dart';
import 'package:customize/core/services/log/log_implementation.dart';
import 'package:customize/core/services/packages/contracts/local_get_storage.dart';
import 'package:customize/core/services/packages/contracts/sqlite_connection.dart';
import 'package:customize/core/services/packages/gateways/local_get_storage_implementation.dart';
import 'package:customize/core/services/service_controller/theme_service_controller.dart';
import 'package:customize/core/values/concatenate/concatenate.dart';

import '../packages/contracts/sqlite_expense.dart';
import '../packages/gateways/sqlite_expense_implementation.dart';
import '../packages/gateways/sqlite_connection_implementation.dart';
import '../service_controller/check_native_darkmode_service_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.putAsync<Log>(
      () => LogImplemetation().getInstance(),
      permanent: true,
    );

    Get.put<CheckNativeDarkmodeServiceController>(
      CheckNativeDarkmodeServiceController(),
      permanent: true,
    );

    Get.lazyPut<SqliteConnection>(
      () => SqliteConnectionImplementation.instance,
    );

    Get.put<SqliteExpense>(SqliteExpenseImplementation(), permanent: true);

    Get.put<Concatenate>(Concatenate(), permanent: true);

    Get.put<LocalGetStorage>(LocalGetStorageImplementation(), permanent: true);

    Get.lazyPut<ThemeServiceController>(
      () => ThemeServiceController(),
      fenix: true,
    );
  }
}
