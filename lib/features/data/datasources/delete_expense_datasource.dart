import 'package:organize_more/core/services/database/tables/expense_database.dart';
import '../../../core/errors/datasource_exception.dart';

abstract class DeleteExpenseDatasource {
  Future<int> delete({
    required int id,
  });
}

class DeleteExpenseDatasourceImplementetion implements DeleteExpenseDatasource {
  final ExpenseDatabase _database;

  DeleteExpenseDatasourceImplementetion({
    required ExpenseDatabase database,
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
