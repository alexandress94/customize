import 'package:organize_more/core/values/concatenate/concatenate.dart';
import 'package:organize_more/features/data/models/expense_model.dart';
import '../../../core/errors/datasource_exception.dart';
import '../../../core/services/packages/contracts/sqlite_expense.dart';

abstract class GetAllExpenseDatasource {
  Future<List<ExpenseModel>> find({
    required DateTime date,
  });
}

class GetAllExpenseDatasourceImplementation implements GetAllExpenseDatasource {
  final SqliteExpense _expenseDatabase;
  final Concatenate concatenate;

  GetAllExpenseDatasourceImplementation({
    required SqliteExpense expenseDatabase,
    required this.concatenate,
  }) : _expenseDatabase = expenseDatabase;

  @override
  Future<List<ExpenseModel>> find({required DateTime date}) async {
    concatenate.selectedDate = date;

    final result = await _expenseDatabase.find(
      paramter: {
        "initial-date": concatenate.firstDayOfMonthAndYear,
        "end-date": concatenate.lastDayOfMonthAndYear,
      },
    );

    if (result.response) {
      List<Map<String, dynamic>> expenses = result.data;
      return expenses
          .map((transactions) => ExpenseModel.fromMap(transactions))
          .toList();
    } else {
      throw DatasourceException.badRequest();
    }
  }
}
