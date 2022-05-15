import '../../../core/errors/datasource_exception.dart';
import '../../../core/services/packages/contracts/sqlite_expense.dart';

abstract class UpdateBetweenExpenseDatasource {
  Future<int> updateBetween({
    required Map<String, dynamic> model,
  });
}

class UpdateBetweenExpenseDatasourceImplementetion
    implements UpdateBetweenExpenseDatasource {
  final SqliteExpense _database;

  UpdateBetweenExpenseDatasourceImplementetion({
    required SqliteExpense database,
  }) : _database = database;

  @override
  Future<int> updateBetween({required Map<String, dynamic> model}) async {
    final result = await _database.updateBetween(model: model);

    if (result.response) {
      final id = result.data as int;
      return id;
    } else {
      throw DatasourceException.badRequest();
    }
  }
}
