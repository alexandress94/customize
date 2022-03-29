import '../../../core/errors/datasource_exception.dart';
import '../../../core/services/packages/contracts/sqlite_expense.dart';

abstract class DeleteAllExpenseDatasource {
  Future<int> deleteAll({
    required String uuId,
  });
}

class DeleteAllExpenseDatasourceImplementetion
    implements DeleteAllExpenseDatasource {
  final SqliteExpense _database;

  DeleteAllExpenseDatasourceImplementetion({
    required SqliteExpense database,
  }) : _database = database;

  @override
  Future<int> deleteAll({required String uuId}) async {
    final result = await _database.deleteAll(uuId: uuId);

    if (result.response) {
      final id = result.data as int;
      return id;
    } else {
      throw DatasourceException.badRequest();
    }
  }
}
