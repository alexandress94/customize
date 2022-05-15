import 'package:organize_more/core/values/converts/convert_text.dart';
import 'package:organize_more/core/values/format/format_date.dart';
import 'package:organize_more/features/domain/entities/expense_entity.dart';

class ExpenseModel extends ExpenseEntity {
  ExpenseModel({
    int? id,
    required String uuId,
    required String description,
    required double valueTransaction,
    required double valueTotal,
    required int installmentNumber,
    required int amountInstallments,
    required String typeTransaction,
    int? isPayment,
    required int isPortion,
    DateTime? datePayment,
    required DateTime transactionDate,
    required DateTime dueDate,
  }) : super(
          id: id,
          uuId: uuId,
          description: description,
          valueTransaction: valueTransaction,
          valueTotal: valueTotal,
          installmentNumber: installmentNumber,
          amountInstallments: amountInstallments,
          typeTransaction: typeTransaction,
          isPayment: isPayment,
          isPortion: isPortion,
          datePayment: datePayment,
          transactionDate: transactionDate,
          dueDate: dueDate,
        );

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      uuId: map['uuId'],
      description: map['ds_transaction'],
      valueTransaction: map['vl_transaction'],
      valueTotal: map['vl_total'],
      installmentNumber: map['nr_installment'],
      amountInstallments: map['qt_installment'],
      isPayment: map['yn_payment'],
      isPortion: map['yn_portion'],
      datePayment: map['dt_payment'] != null
          ? ConvertText.toDate(value: map['dt_payment'])
          : DateTime.now(),
      transactionDate: ConvertText.toDate(value: map['dt_transaction']),
      dueDate: ConvertText.toDate(value: map['dt_due']),
      typeTransaction: map['tp_transaction'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuId': uuId,
      'ds_transaction': description,
      'vl_transaction': valueTransaction,
      'vl_total': valueTotal,
      'nr_installment': installmentNumber,
      'qt_installment': amountInstallments,
      'yn_payment': isPayment,
      'yn_portion': isPortion,
      'tp_transaction': typeTransaction,
      'dt_payment': datePayment != null
          ? FormatDate.replaceMaskDateForDatabase(date: datePayment!)
          : null,
      'dt_transaction': FormatDate.replaceMaskDateForDatabase(
        date: transactionDate,
      ),
      'dt_due': FormatDate.replaceMaskDateForDatabase(
        date: dueDate,
      ),
    };
  }

  @override
  String toString() {
    return 'ExpenseModel{id: $id, uuId: $uuId, description: $description, valueTransaction: $valueTransaction, installmentNumber: $installmentNumber, isPayment: $isPayment, isPortion: $isPortion, datePayment: $datePayment, transactionDate: $transactionDate, dueDate: $dueDate, typeTransaction: $typeTransaction}';
  }
}
