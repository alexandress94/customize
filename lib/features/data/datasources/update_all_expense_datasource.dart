import '../../../core/errors/datasource_exception.dart';
import '../../../core/services/packages/contracts/sqlite_expense.dart';

abstract class UpdateAllExpenseDatasource {
  Future<int> updateAll({
    required Map<String, dynamic> model,
  });
}

class UpdateAllExpenseDatasourceImplementetion
    implements UpdateAllExpenseDatasource {
  final SqliteExpense _database;

  UpdateAllExpenseDatasourceImplementetion({
    required SqliteExpense database,
  }) : _database = database;

  @override
  Future<int> updateAll({required Map<String, dynamic> model}) async {
    final result = await _database.updateAll(model: model);

    if (result.response) {
      final id = result.data as int;
      return id;
    } else {
      throw DatasourceException.badRequest();
    }
  }
}
