import 'package:customize/core/values/concatenate/concatenate.dart';
import 'package:customize/features/data/models/amount_model.dart';

import '../../../core/errors/datasource_exception.dart';
import '../../../core/services/packages/contracts/sqlite_expense.dart';

abstract class GetSumOfTransactionsDatasource {
  Future<List<AmountModel>> getSum({required DateTime date});
}

class GetSumOfTrasactionsDatasourceImplementetion
    implements GetSumOfTransactionsDatasource {
  final SqliteExpense _database;
  final Concatenate concatenate;
  GetSumOfTrasactionsDatasourceImplementetion({
    required SqliteExpense database,
    required this.concatenate,
  }) : _database = database;

  @override
  Future<List<AmountModel>> getSum({required DateTime date}) async {
    concatenate.selectedDate = date;
    final result = await _database.sumOfTransactions(
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
