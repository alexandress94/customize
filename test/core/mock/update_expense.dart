import 'package:customize/core/values/format/format_date.dart';
import 'package:customize/features/domain/usecases/update_all_expense_usecase.dart';

import 'filter_date.dart';

var tUpdateExpenseParameter = ParameterUpdateAllExpense(
  id: 1,
  date: FormatDate.replaceMaskDateForDatabase(
    date: tFilterDate,
  ),
  description: 'conta de agua',
  total: 150.0,
  uuId: '5792f0fc-8a27-4cc0-8848-12f6089f1b2f',
  value: 150.0,
);

Map<String, dynamic> tUpdateExpenseModel = {
  "id": 1,
  "uuId": '5792f0fc-8a27-4cc0-8848-12f6089f1b2f',
  "ds_transaction": 'conta de agua',
  "vl_transaction": 150.0,
  "vl_total": 150.0,
  "dt_due": FormatDate.replaceMaskDateForDatabase(
    date: tFilterDate,
  ),
};
