import 'package:organize_more/core/services/database/tables/expense_database.dart';
import 'package:organize_more/core/values/format/format_date.dart';
import 'package:organize_more/features/data/models/amount_model.dart';
import 'package:organize_more/core/errors/repository_exception.dart';

import '../../../core/errors/datasource_exception.dart';

abstract class UpdatePaymentDatasource {
  Future<int> updateExpense({
    required int id,
    required int portion,
  });
}

class UpdatePaymentDatasourceImplementetion implements UpdatePaymentDatasource {
  final ExpenseDatabase _database;

  UpdatePaymentDatasourceImplementetion({
    required ExpenseDatabase database,
  }) : _database = database;

  @override
  Future<int> updateExpense({
    required int id,
    required int portion,
  }) async {
    final result = await _database.update(
      model: {
        "id": id,
        "nr_installment": portion,
        "yn_payment": 1,
        "dt_payment": FormatDate.replaceMaskDateForDatabase(
          date: DateTime.now(),
        ),
      },
    );

    if (result.response) {
      final int id = result.data;
      return id;
    } else {
      throw DatasourceException.badRequest();
    }
  }
}
