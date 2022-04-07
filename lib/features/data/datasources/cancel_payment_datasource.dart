import '../../../core/errors/datasource_exception.dart';
import '../../../core/services/packages/contracts/sqlite_expense.dart';

abstract class CancelPaymentDatasource {
  Future<int> cancelPayment({
    required int id,
    required int portion,
  });
}

class CancelPaymentDatasourceImplementetion implements CancelPaymentDatasource {
  final SqliteExpense _database;

  CancelPaymentDatasourceImplementetion({
    required SqliteExpense database,
  }) : _database = database;

  @override
  Future<int> cancelPayment({
    required int id,
    required int portion,
  }) async {
    final result = await _database.cancelPayment(
      model: {
        "id": id,
        "nr_installment": portion,
        "yn_payment": 0,
        "dt_payment": null,
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
