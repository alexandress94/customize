import 'package:organize_more/core/values/format/format_date.dart';
import 'package:organize_more/features/domain/entities/expense_entity.dart';

class ExpenseDto {
  final int? id;
  final String description;
  final double valueTransaction;
  final int installmentNumber;
  final int amountInstallments;
  final int? isPayment;
  final int isPortion;
  final DateTime? datePayment;
  final DateTime transactionDate;
  final DateTime dueDate;

  ExpenseDto({
    this.id,
    required this.description,
    required this.valueTransaction,
    required this.installmentNumber,
    required this.amountInstallments,
    this.isPayment,
    required this.isPortion,
    this.datePayment,
    required this.transactionDate,
    required this.dueDate,
  });

  factory ExpenseDto.fromEntity({required ExpenseEntity entity}) {
    return ExpenseDto(
      id: entity.id,
      description: entity.description,
      valueTransaction: entity.valueTransaction,
      installmentNumber: entity.installmentNumber,
      amountInstallments: entity.amountInstallments,
      isPayment: entity.isPayment,
      isPortion: entity.isPortion,
      datePayment: entity.datePayment!,
      transactionDate: entity.transactionDate,
      dueDate: entity.dueDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ds_transaction': description,
      'vl_transaction': valueTransaction,
      'nr_installment': installmentNumber,
      'qt_installment': amountInstallments,
      'yn_payment': isPayment,
      'yn_portion': isPortion,
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
    return 'ExpenseDto{id: $id, description: $description, valueTransaction: $valueTransaction, installmentNumber: $installmentNumber, isPayment: $isPayment, isPortion: $isPortion, datePayment: $datePayment, transactionDate: $transactionDate, dueDate: $dueDate}';
  }
}
