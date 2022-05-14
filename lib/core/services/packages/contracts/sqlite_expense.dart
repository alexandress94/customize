import '../../response/sqlite_response.dart';

abstract class SqliteExpense {
  Future<SqliteResponse> find({Map<String, dynamic>? paramter});

  Future<SqliteResponse> insert({required Map<String, dynamic> model});

  Future<SqliteResponse> update({required Map<String, dynamic> model});

  Future<SqliteResponse> updatePayment({required Map<String, dynamic> model});

  Future<SqliteResponse> cancelPayment({required Map<String, dynamic> model});

  Future<SqliteResponse> delete({required int id});

  Future<SqliteResponse> deleteBetween({Map<String, dynamic>? parameter});

  Future<SqliteResponse> deleteAll({required String uuId});

  Future<SqliteResponse> sumOfTransactions({Map<String, dynamic>? parameter});

  Future<SqliteResponse> paymentSum({Map<String, dynamic>? parameter});

  Future<SqliteResponse> sumOfExpenses({Map<String, dynamic>? parameter});

  Future<SqliteResponse> totalOfExpense(String uuId);
}
