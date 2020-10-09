
import 'dart:io';

import 'package:energia_perosnalapp_sql/Model/MyExpences.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class database_helper{
  static Database _db;
  final String ExpensesTable = 'ExpensesTable';
  final String columnId = 'id';
  final String columntitle = 'title';
  final String columndata = 'data';
  final String columnamount = 'amount';

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await intDB();
    return _db;
  }
  intDB() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path , 'mydb.db');
    var myOwnDB = await openDatabase(path,version: 1,
        onCreate: _onCreate);
    return myOwnDB;
  }

  void _onCreate(Database db , int newVersion) async{
    var sql = "CREATE TABLE $ExpensesTable ($columnId INTEGER PRIMARY KEY,"
        " $columntitle TEXT, $columndata TEXT,$columnamount INTEGER )";
    await db.execute(sql);
  }
  Future<int> saveExpense( MyExpences myexpences) async{
    var dbClient = await  db;
    int result = await dbClient.insert("$ExpensesTable", myexpences.toMap());
    return result;
  }

  Future<List> getAllExpences() async{
    var dbClient = await  db;
    return await dbClient.query(ExpensesTable);
   // var sql = "SELECT * FROM $ExpensesTable";
    //List result = await dbClient.rawQuery(sql);
 //   return result.toList();
  }
  Future<int> delete({int id}) async{
    var dbclient = await db;
    int delete = await dbclient.rawUpdate('DELETE FROM $ExpensesTable  where id ="$id" ');
    return delete;
  }
  Future<int> deleteUser(int id) async{
    var dbClient = await  db;
    return  await dbClient.delete(
        ExpensesTable , where: "$columnId = ?" , whereArgs: [id]
    );
  }
}