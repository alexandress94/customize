import 'package:organize_more/core/services/database/tables/expense_database.dart';
import 'package:organize_more/core/errors/repository_exception.dart';

import '../../../core/errors/datasource_exception.dart';

abstract class InsertExpenseDatasource {
  Future<int> insertExpense({required Map<String, dynamic> model});
}

class InsertExpenseDatasourceImplementation implements InsertExpenseDatasource {
  final ExpenseDatabase _database;

  InsertExpenseDatasourceImplementation({
    required ExpenseDatabase database,
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
