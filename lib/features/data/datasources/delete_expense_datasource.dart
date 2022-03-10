import '../../../core/errors/datasource_exception.dart';
import '../../../core/services/packages/contracts/sqlite_expense.dart';

abstract class DeleteExpenseDatasource {
  Future<int> delete({
    required int id,
  });
}

class DeleteExpenseDatasourceImplementetion implements DeleteExpenseDatasource {
  final SqliteExpense _database;

  DeleteExpenseDatasourceImplementetion({
    required SqliteExpense database,
  }) : _database = database;

  @override
  Future<int> delete({
    required int id,
  }) async {
    final result = await _database.delete(id: id);

    if (result.response) {
      final id = result.data;
      return id;
    } else {
      throw DatasourceException.badRequest();
    }
  }
}
