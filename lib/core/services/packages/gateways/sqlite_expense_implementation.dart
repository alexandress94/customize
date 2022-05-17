import 'package:customize/core/services/log/log.dart';
import 'package:customize/core/services/log/log_implementation.dart';
import 'package:customize/core/services/packages/gateways/sqlite_connection_implementation.dart';
import 'package:sqflite/sqflite.dart';
import '../../response/sqlite_response.dart';
import '../contracts/sqlite_expense.dart';

class SqliteExpenseImplementation implements SqliteExpense {
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
  static const String _columnUuIdTransaction = 'uuId';
  static const String _columnDsTransaction = 'ds_transaction';
  static const String _columnVlTransaction = 'vl_transaction';
  static const String _columnVlTotal = 'vl_total';
  static const String _columnNrInstallment = 'nr_installment';
  static const String _columnQtInstallment = 'qt_installment';
  static const String _columnYnPayment = 'yn_payment';
  static const String _columnYnPortion = 'yn_portion';
  static const String _columnDtPayment = 'dt_payment';
  static const String _columnTpTransaction = 'tp_transaction';
  static const String _columnDtTransaction = 'dt_transaction';
  static const String _columnDtDue = 'dt_due';

  static const String createTableExpense = "CREATE TABLE IF NOT EXISTS $_table("
      "$_columnIdTransaction INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$_columnUuIdTransaction TEXT,"
      "$_columnDsTransaction TEXT NOT NULL,"
      "$_columnVlTransaction REAL NOT NULL,"
      "$_columnVlTotal REAL NOT NULL,"
      "$_columnNrInstallment INTEGER NOT NULL,"
      "$_columnYnPortion INTEGER NOT NULL,"
      "$_columnQtInstallment INTEGER NOT NULL,"
      "$_columnDtPayment TEXT,"
      "$_columnYnPayment INTEGER NOT NULL,"
      "$_columnDtTransaction TEXT NOT NULL,"
      "$_columnTpTransaction TEXT NOT NULL,"
      "$_columnDtDue TEXT NOT NULL"
      ");";

  @override
  Future<SqliteResponse> delete({required int id}) async {
    Database database = await SqliteConnectionImplementation.instance.database;
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
    return SqliteResponse(data: result, response: true);
  }

  @override
  Future<SqliteResponse> insert({required Map<String, dynamic> model}) async {
    Database database = await SqliteConnectionImplementation.instance.database;
    final int result = await database.insert(_table, model);
    _logs(
      method: 'INSERT',
      parameters: model,
      response: 'TRANSAÇÃO INSERIDO ID: $result',
      statusCode: true,
    );
    return SqliteResponse(data: result, response: true);
  }

  @override
  Future<SqliteResponse> update({
    required Map<String, dynamic> model,
  }) async {
    Database database = await SqliteConnectionImplementation.instance.database;

    final id = model['id'] as int;
    final uuId = model['uuId'] as String;
    final description = model['ds_transaction'] as String;
    final value = model['vl_transaction'] as double;
    final dueDate = model['dt_due'] as String;

    final Map<String, dynamic> map = {
      'ds_transaction': description,
      'vl_transaction': value,
      'dt_due': dueDate,
    };
    final int result = await database.update(
      _table,
      map,
      where: "$_columnIdTransaction = ?",
      whereArgs: [id],
    );

    final response = await totalOfExpense(uuId);

    if (response.response) {
      final Map<String, dynamic> singleMap = {
        'vl_total': response.data[0]['vl_transaction'] as double,
      };
      await database.update(
        _table,
        singleMap,
        where: "$_columnUuIdTransaction = ?",
        whereArgs: [uuId],
      );
    }

    _logs(
      method: 'UPDATE',
      parameters: model,
      response: 'TRANSAÇÃO ATUALIZADO ID: $result',
      statusCode: true,
    );
    return SqliteResponse(data: result, response: true);
  }

  @override
  Future<SqliteResponse> find({Map<String, dynamic>? paramter}) async {
    Database database = await SqliteConnectionImplementation.instance.database;

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
    return SqliteResponse(data: result, response: true);
  }

  @override
  Future<SqliteResponse> sumOfTransactions({
    Map<String, dynamic>? parameter,
  }) async {
    Database database = await SqliteConnectionImplementation.instance.database;

    String sql = '''
    SELECT SUM($_columnVlTransaction) as $_columnVlTransaction FROM $_table  
      WHERE $_columnDtDue BETWEEN 
      DATE('${parameter?['initial-date']}') 
      AND DATE('${parameter?['end-date']}') 
    ''';

    final List<Map<String, dynamic>> result = await database.rawQuery(sql);

    _logs(
      method: 'SELECT',
      parameters: parameter,
      body: sql,
      response: result,
      statusCode: true,
    );

    return SqliteResponse(data: result, response: true);
  }

  @override
  Future<SqliteResponse> paymentSum({Map<String, dynamic>? parameter}) async {
    Database database = await SqliteConnectionImplementation.instance.database;

    String sql = '''
    SELECT SUM($_columnVlTransaction) as $_columnVlTransaction FROM $_table  
      WHERE $_columnDtDue BETWEEN 
      DATE('${parameter?['initial-date']}') 
      AND DATE('${parameter?['end-date']}')
      AND $_columnYnPayment = 1
    ''';

    final List<Map<String, dynamic>> result = await database.rawQuery(sql);
    _logs(
      method: 'SELECT',
      parameters: parameter,
      body: sql,
      response: result,
      statusCode: true,
    );
    return SqliteResponse(data: result, response: true);
  }

  @override
  Future<SqliteResponse> sumOfExpenses({
    Map<String, dynamic>? parameter,
  }) async {
    Database database = await SqliteConnectionImplementation.instance.database;

    String sql = '''
    SELECT SUM($_columnVlTransaction) as $_columnVlTransaction FROM $_table  
      WHERE $_columnDtDue BETWEEN 
      DATE('${parameter?['initial-date']}') 
      AND DATE('${parameter?['end-date']}') 
      AND $_columnYnPayment = 0
    ''';

    final List<Map<String, dynamic>> result = await database.rawQuery(sql);
    _logs(
      method: 'SELECT',
      parameters: parameter,
      body: sql,
      response: result,
      statusCode: true,
    );
    return SqliteResponse(data: result, response: true);
  }

  @override
  Future<SqliteResponse> deleteAll({required String uuId}) async {
    Database database = await SqliteConnectionImplementation.instance.database;

    String sql = '''
      DELETE FROM $_table WHERE $_columnUuIdTransaction = ?
      ''';

    final int result = await database.rawDelete(sql, [uuId]);

    _logs(
      method: 'DELETE ALL',
      parameters: uuId,
      response: 'TRANSAÇÃO DELETADO ID: $result',
      statusCode: true,
    );
    return SqliteResponse(data: result, response: true);
  }

  @override
  Future<SqliteResponse> deleteBetween({
    Map<String, dynamic>? parameter,
  }) async {
    Database database = await SqliteConnectionImplementation.instance.database;
    String id = parameter!['id'].toString();
    String uuId = parameter['uuId'];

    String sql = '''
      DELETE FROM $_table WHERE $_columnIdTransaction >= ?
      AND $_columnUuIdTransaction = ?
      ''';

    final int result = await database.rawDelete(
      sql,
      [id, uuId],
    );

    _logs(
      method: 'DELETE BETWEEN',
      parameters: parameter,
      response: 'TRANSAÇÃO DELETADO ID: $result',
      statusCode: true,
    );
    return SqliteResponse(data: result, response: true);
  }

  @override
  Future<SqliteResponse> updatePayment({
    required Map<String, dynamic> model,
  }) async {
    Database database = await SqliteConnectionImplementation.instance.database;

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
    return SqliteResponse(data: result, response: true);
  }

  @override
  Future<SqliteResponse> cancelPayment({
    required Map<String, dynamic> model,
  }) async {
    Database database = await SqliteConnectionImplementation.instance.database;

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
    return SqliteResponse(data: result, response: true);
  }

  @override
  Future<SqliteResponse> totalOfExpense(String uuId) async {
    Database database = await SqliteConnectionImplementation.instance.database;

    String sql = '''
    SELECT SUM($_columnVlTransaction) as $_columnVlTransaction FROM $_table
    WHERE $_columnUuIdTransaction = '$uuId'
    ''';

    final List<Map<String, dynamic>> result = await database.rawQuery(sql);

    _logs(
      method: 'SELECT',
      parameters: uuId,
      body: sql,
      response: result,
      statusCode: true,
    );
    return SqliteResponse(data: result, response: true);
  }

  @override
  Future<SqliteResponse> updateBetween({Map<String, dynamic>? model}) async {
    Database database = await SqliteConnectionImplementation.instance.database;
    final id = model!['id'] as int;
    final uuId = model['uuId'] as String;
    final description = model['ds_transaction'] as String;
    final value = model['vl_transaction'] as double;
    final dueDate = model['dt_due'] as String;

    final Map<String, dynamic> map = {
      'ds_transaction': description,
      'vl_transaction': value,
    };

    final int result = await database.update(
      _table,
      map,
      where: "$_columnIdTransaction >= ? AND $_columnUuIdTransaction = ?",
      whereArgs: [id, uuId],
    );
    final Map<String, dynamic> mapDueDate = {'dt_due': dueDate};

    await database.update(
      _table,
      mapDueDate,
      where: "$_columnIdTransaction = ?",
      whereArgs: [id],
    );

    final response = await totalOfExpense(uuId);

    if (response.response) {
      final Map<String, dynamic> singleMap = {
        'vl_total': response.data[0]['vl_transaction'] as double,
      };
      await database.update(
        _table,
        singleMap,
        where: "$_columnUuIdTransaction = ?",
        whereArgs: [uuId],
      );
    }

    _logs(
      method: 'UPDATE BETWEEN',
      parameters: model,
      response: 'TRANSAÇÃO UPDATE ID: $result',
      statusCode: true,
    );
    return SqliteResponse(data: result, response: true);
  }

  @override
  Future<SqliteResponse> updateAll({Map<String, dynamic>? model}) async {
    Database database = await SqliteConnectionImplementation.instance.database;
    final id = model!['id'] as int;
    final uuId = model['uuId'] as String;
    final description = model['ds_transaction'] as String;
    final value = model['vl_transaction'] as double;
    final dueDate = model['dt_due'] as String;

    final Map<String, dynamic> map = {
      'ds_transaction': description,
      'vl_transaction': value,
    };

    final int result = await database.update(
      _table,
      map,
      where: "$_columnUuIdTransaction = ?",
      whereArgs: [uuId],
    );
    final Map<String, dynamic> mapDueDate = {'dt_due': dueDate};

    await database.update(
      _table,
      mapDueDate,
      where: "$_columnIdTransaction = ?",
      whereArgs: [id],
    );

    final response = await totalOfExpense(uuId);

    if (response.response) {
      final Map<String, dynamic> singleMap = {
        'vl_total': response.data[0]['vl_transaction'] as double,
      };
      await database.update(
        _table,
        singleMap,
        where: "$_columnUuIdTransaction = ?",
        whereArgs: [uuId],
      );
    }

    _logs(
      method: 'UPDATE ALL',
      parameters: model,
      response: 'TRANSAÇÃO UPDATE ID: $result',
      statusCode: true,
    );
    return SqliteResponse(data: result, response: true);
  }
}
