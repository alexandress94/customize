import '../../../core/errors/datasource_exception.dart';
import '../../../core/services/packages/contracts/sqlite_expense.dart';

abstract class InsertExpenseDatasource {
  Future<int> insertExpense({required Map<String, dynamic> model});
}

class InsertExpenseDatasourceImplementation implements InsertExpenseDatasource {
  final SqliteExpense _database;

  InsertExpenseDatasourceImplementation({
    required SqliteExpense database,
  }) : _database = database;
  @override
  Future<int> insertExpense({required Map<String, dynamic> model}) async {
    final result = await _database.insert(model: model);

    if (result.response) {
      return result.data;
    } else {
      throw DatasourceException.badRequest();
    }
  }
}
