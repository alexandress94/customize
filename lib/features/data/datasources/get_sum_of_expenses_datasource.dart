import 'package:organize_more/core/errors/repository_exception.dart';
import 'package:organize_more/core/services/database/tables/expense_database.dart';
import 'package:organize_more/core/values/concatenate/concatenate.dart';
import 'package:organize_more/features/data/models/amount_model.dart';

import '../../../core/errors/datasource_exception.dart';

abstract class GetSumOfExpensesDatasource {
  Future<List<AmountModel>> getSum({required DateTime date});
}

class GetSumOfExpensesDatasourceImplementetion
    implements GetSumOfExpensesDatasource {
  final ExpenseDatabase _database;
  final Concatenate concatenate;
  GetSumOfExpensesDatasourceImplementetion({
    required ExpenseDatabase database,
    required this.concatenate,
  }) : _database = database;

  @override
  Future<List<AmountModel>> getSum({required DateTime date}) async {
    concatenate.selectedDate = date;
    final result = await _database.sumOfExpenses(
      paramter: {
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
