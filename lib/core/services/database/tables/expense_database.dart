import 'package:organize_more/core/services/log/log.dart';
import 'package:organize_more/core/services/log/log_implementation.dart';
import 'package:organize_more/core/services/response/database_response.dart';
import 'package:sqflite/sqflite.dart';
import '../connection_database.dart';

class ExpenseDatabase implements Response {
  final Log _log = LogImplemetation();

  void _logs({
    dynamic parameters,
    String? body,
    required dynamic response,
    required String method,
    required bool statusCode,
  }) {
    _log.append('############### $method ###############');
    _log.append('PARAMETERS: $parameters');
    _log.append('StatusCode: $statusCode');
    _log.append('SQL: $body');
    _log.append('RESPONSE: $response');
    _log.append('######################################');
    _log.closeAppend();
  }

  // Nome da tabela
  static const String _table = 'tb_transaction';

  // Nome da coluna da tabela
  static const String _columnIdTransaction = 'id';
  static const String _columnDsTransaction = 'ds_transaction';
  static const String _columnVlTransaction = 'vl_transaction';
  static const String _columnNrInstallment = 'nr_installment';
  static const String _columnQtInstallment = 'qt_installment';
  static const String _columnYnPayment = 'yn_payment';
  static const String _columnYnPortion = 'yn_portion';
  static const String _columnDtPayment = 'dt_payment';
  static const String _columnDtTransaction = 'dt_transaction';
  static const String _columnDtDue = 'dt_due';

  static const String createTableExpense = "CREATE TABLE IF NOT EXISTS $_table("
      "$_columnIdTransaction INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$_columnDsTransaction TEXT NOT NULL,"
      "$_columnVlTransaction REAL NOT NULL,"
      "$_columnNrInstallment INTEGER NOT NULL,"
      "$_columnYnPortion INTEGER NOT NULL,"
      "$_columnQtInstallment INTEGER NOT NULL,"
      "$_columnDtPayment TEXT,"
      "$_columnYnPayment INTEGER NOT NULL,"
      "$_columnDtTransaction TEXT NOT NULL,"
      "$_columnDtDue TEXT NOT NULL"
      ");";

  @override
  Future<DatabaseResponse> delete({required int id}) async {
    Database database = await ConnectionDatabase.instance.database;
    final int result = await database.delete(
      _table,
      where: '$_columnIdTransaction = ?',
      whereArgs: [id],
    );
    _logs(
      method: 'DELETE',
      parameters: id,
      response: 'TRANSAÇÃO DELETADO ID: $result',
      statusCode: true,
    );
    return DatabaseResponse(data: result, response: true);
  }

  Future<DatabaseResponse> deleteAll({required int id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<DatabaseResponse> deleteBetween({required int id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<DatabaseResponse> insert({required Map<String, dynamic> model}) async {
    Database database = await ConnectionDatabase.instance.database;
    final int result = await database.insert(_table, model);
    _logs(
      method: 'INSERT',
      parameters: model,
      response: 'TRANSAÇÃO INSERIDO ID: $result',
      statusCode: true,
    );
    return DatabaseResponse(data: result, response: true);
  }

  @override
  Future<DatabaseResponse> update({
    required Map<String, dynamic> model,
  }) async {
    Database database = await ConnectionDatabase.instance.database;

    final int result = await database.update(
      _table,
      model,
      where: "$_columnIdTransaction = ?",
      whereArgs: [model['id']],
    );

    _logs(
      method: 'UPDATE',
      parameters: model,
      response: 'TRANSAÇÃO ATUALIZADO ID: $result',
      statusCode: true,
    );
    return DatabaseResponse(data: result, response: true);
  }

  @override
  Future<DatabaseResponse> find({Map<String, dynamic>? paramter}) async {
    Database database = await ConnectionDatabase.instance.database;

    String sql = '''
    SELECT * FROM $_table  
      WHERE $_columnDtDue BETWEEN 
      DATE('${paramter?['initial-date']}') 
      AND DATE('${paramter?['end-date']}') 
      ORDER BY $_columnDtDue DESC
    ''';

    final List<Map<String, dynamic>> result = await database.rawQuery(sql);
    _logs(
      method: 'SELECT',
      parameters: paramter,
      body: sql,
      response: result,
      statusCode: true,
    );
    return DatabaseResponse(data: result, response: true);
  }

  Future<DatabaseResponse> sumOfTransactions(
      {Map<String, dynamic>? paramter}) async {
    Database database = await ConnectionDatabase.instance.database;

    String sql = '''
    SELECT SUM($_columnVlTransaction) as $_columnVlTransaction FROM $_table  
      WHERE $_columnDtDue BETWEEN 
      DATE('${paramter?['initial-date']}') 
      AND DATE('${paramter?['end-date']}') 
    ''';

    final List<Map<String, dynamic>> result = await database.rawQuery(sql);

    _logs(
      method: 'SELECT',
      parameters: paramter,
      body: sql,
      response: result,
      statusCode: true,
    );

    return DatabaseResponse(data: result, response: true);
  }

  Future<DatabaseResponse> paymentSum({Map<String, dynamic>? paramter}) async {
    Database database = await ConnectionDatabase.instance.database;

    String sql = '''
    SELECT SUM($_columnVlTransaction) as $_columnVlTransaction FROM $_table  
      WHERE $_columnDtDue BETWEEN 
      DATE('${paramter?['initial-date']}') 
      AND DATE('${paramter?['end-date']}')
      AND $_columnYnPayment = 1
    ''';

    final List<Map<String, dynamic>> result = await database.rawQuery(sql);
    _logs(
      method: 'SELECT',
      parameters: paramter,
      body: sql,
      response: result,
      statusCode: true,
    );
    return DatabaseResponse(data: result, response: true);
  }

  Future<DatabaseResponse> sumOfExpenses(
      {Map<String, dynamic>? paramter}) async {
    Database database = await ConnectionDatabase.instance.database;

    String sql = '''
    SELECT SUM($_columnVlTransaction) as $_columnVlTransaction FROM $_table  
      WHERE $_columnDtDue BETWEEN 
      DATE('${paramter?['initial-date']}') 
      AND DATE('${paramter?['end-date']}') 
      AND $_columnYnPayment = 0
    ''';

    final List<Map<String, dynamic>> result = await database.rawQuery(sql);
    _logs(
      method: 'SELECT',
      parameters: paramter,
      body: sql,
      response: result,
      statusCode: true,
    );
    return DatabaseResponse(data: result, response: true);
  }
}
