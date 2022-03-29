class ExpenseEntity {
  final int? id;
  final String? uuId;
  final String description;
  final double valueTransaction;
  final int installmentNumber;
  final int amountInstallments;
  final int? isPayment;
  final int isPortion;
  final DateTime? datePayment;
  final DateTime transactionDate;
  final DateTime dueDate;

  ExpenseEntity({
    this.id,
    this.uuId,
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
}
