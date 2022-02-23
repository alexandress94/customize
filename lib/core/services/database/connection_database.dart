import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'tables/expense_database.dart';
import 'dart:io';

class ConnectionDatabase {
  static const String _databaseName = 'organize.db';
  static const int _databaseVersion = 1;

  ConnectionDatabase._privateConstructor();

  static final ConnectionDatabase instance =
      ConnectionDatabase._privateConstructor();

  static Database? _database;

  // Criando o banco de dados.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializando o banco de dadaos.
  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + _databaseName;
    var database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate, /*onUpgrade: _onUpgrade,*/
    );
    return database;
  }

  void _onCreate(Database database, int version) async {
    await database.execute(ExpenseDatabase.createTableExpense);
  }

  //  Atualização de versão do banco.
  // Future<void> _onUpgrade(
  //     Database database, int oldVersion, int newVersion) async {
  //   if (oldVersion < 2) {
  //     database.execute('INSERIR A QUERY AQUI');
  //   } else {
  //     throw Exception('Falha na atualização de versão do banco!');
  //   }
  // }
}
