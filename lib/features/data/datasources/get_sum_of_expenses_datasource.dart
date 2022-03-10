import 'package:organize_more/core/values/concatenate/concatenate.dart';
import 'package:organize_more/features/data/models/amount_model.dart';

import '../../../core/errors/datasource_exception.dart';
import '../../../core/services/packages/contracts/sqlite_expense.dart';

abstract class GetSumOfExpensesDatasource {
  Future<List<AmountModel>> getSum({required DateTime date});
}

class GetSumOfExpensesDatasourceImplementetion
    implements GetSumOfExpensesDatasource {
  final SqliteExpense _database;
  final Concatenate concatenate;
  GetSumOfExpensesDatasourceImplementetion({
    required SqliteExpense database,
    required this.concatenate,
  }) : _database = database;

  @override
  Future<List<AmountModel>> getSum({required DateTime date}) async {
    concatenate.selectedDate = date;
    final result = await _database.sumOfExpenses(
      parameter: {
        "initial-date": concatenate.firstDayOfMonthAndYear,
        "end-date": concatenate.lastDayOfMonthAndYear,
      },
    );

    if (result.response) {
      List<Map<String, dynamic>> values = result.data;
      return values.map((sum) => AmountModel.fromMap(sum)).toList();
    } else {
      throw DatasourceException.badRequest();
    }
  }
}
