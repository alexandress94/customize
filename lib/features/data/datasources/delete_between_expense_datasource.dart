import '../../../core/errors/datasource_exception.dart';
import '../../../core/services/packages/contracts/sqlite_expense.dart';

abstract class DeleteBetweenExpenseDatasource {
  Future<int> deleteBetween({
    required Map<String, dynamic> model,
  });
}

class DeleteBetweenExpenseDatasourceImplementetion
    implements DeleteBetweenExpenseDatasource {
  final SqliteExpense _database;

  DeleteBetweenExpenseDatasourceImplementetion({
    required SqliteExpense database,
  }) : _database = database;

  @override
  Future<int> deleteBetween({
    required Map<String, dynamic> model,
  }) async {
    final result = await _database.deleteBetween(parameter: model);

    if (result.response) {
      final id = result.data as int;
      return id;
    } else {
      throw DatasourceException.badRequest();
    }
  }
}
