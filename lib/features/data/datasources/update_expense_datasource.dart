import '../../../core/errors/datasource_exception.dart';
import '../../../core/services/packages/contracts/sqlite_expense.dart';

abstract class UpdateExpenseDatasource {
  Future<int> updateExpense({
    required Map<String, dynamic> model,
  });
}

class UpdateExpenseDatasourceImplementetion implements UpdateExpenseDatasource {
  final SqliteExpense _database;

  UpdateExpenseDatasourceImplementetion({
    required SqliteExpense database,
  }) : _database = database;

  @override
  Future<int> updateExpense({
    required Map<String, dynamic> model,
  }) async {
    final result = await _database.update(model: model);

    if (result.response) {
      final id = result.data as int;
      return id;
    } else {
      throw DatasourceException.badRequest();
    }
  }
}
