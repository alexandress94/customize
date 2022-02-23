import 'package:organize_more/core/services/database/connection_database.dart';
import 'package:organize_more/core/services/database/tables/expense_database.dart';
import 'package:get/get.dart';
import 'package:organize_more/core/services/log/log.dart';
import 'package:organize_more/core/services/log/log_implementation.dart';
import 'package:organize_more/core/values/concatenate/concatenate.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.putAsync<Log>(
      () => LogImplemetation().getInstance(),
      permanent: true,
    );

    Get.lazyPut<ConnectionDatabase>(
      () => ConnectionDatabase.instance,
    );

    Get.put<ExpenseDatabase>(ExpenseDatabase(), permanent: true);

    Get.put<Concatenate>(Concatenate(), permanent: true);
  }
}
