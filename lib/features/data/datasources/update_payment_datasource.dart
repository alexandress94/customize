import 'package:organize_more/core/values/format/format_date.dart';
import '../../../core/errors/datasource_exception.dart';
import '../../../core/services/packages/contracts/sqlite_expense.dart';

abstract class UpdatePaymentDatasource {
  Future<int> updatePayment({
    required int id,
    required int portion,
  });
}

class UpdatePaymentDatasourceImplementetion implements UpdatePaymentDatasource {
  final SqliteExpense _database;

  UpdatePaymentDatasourceImplementetion({
    required SqliteExpense database,
  }) : _database = database;

  @override
  Future<int> updatePayment({
    required int id,
    required int portion,
  }) async {
    final result = await _database.updatePayment(
      model: {
        "id": id,
        "nr_installment": portion,
        "yn_payment": 1,
        "dt_payment": FormatDate.replaceMaskDateForDatabase(
          date: DateTime.now(),
        ),
      },
    );

    if (result.response) {
      final int id = result.data;
      return id;
    } else {
      throw DatasourceException.badRequest();
    }
  }
}
