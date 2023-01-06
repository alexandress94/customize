import 'package:customize/core/values/format/format_date.dart';

import 'filter_date.dart';

Map<String, dynamic> tInsertExpenseParameter = {
  'uuId': '5792f0fc-8a27-4cc0-8848-12f6089f1b2f',
  'ds_transaction': 'conta de agua',
  'vl_transaction': 150.0,
  'vl_total': 150.0,
  'nr_installment': 1,
  'qt_installment': 1,
  'yn_payment': 0,
  'yn_portion': 0,
  'tp_transaction': 'Mensal',
  'dt_payment': FormatDate.replaceMaskDateForDatabase(
    date: tFilterDate,
  ),
  'dt_transaction': FormatDate.replaceMaskDateForDatabase(
    date: tFilterDate,
  ),
  'dt_due': FormatDate.replaceMaskDateForDatabase(
    date: tFilterDate,
  ),
};
