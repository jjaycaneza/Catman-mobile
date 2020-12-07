import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' ;
import '../../models/countsheet.dart';
import 'dart:convert';

class DatabaseService{
  
  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  Future<dynamic> _createDatabase() async{
    print("creating db");
    
    String databasePath = await getDatabasesPath();
    // deleteDatabase(join(databasePath,'gaisano_catman.db'));
    String dbPath = join(databasePath,'gaisano_catman.db');
    return await openDatabase(dbPath,version:1,onCreate:_populateDB);
   
  }
  static Database _database;
  Future<Database> get database async {
  
    if (_database != null) return _database;
      _database = await _createDatabase();
      return _database;
  }

  void _populateDB(Database database,int version) async{
    await database.execute("""CREATE TABLE tbl_countsheet (countsheet_id INTEGER PRIMARY KEY  AUTOINCREMENT,
        count_id TEXT,parent_group_name TEXT,item_group_name TEXT,synced INT(1),synced_date DATETIME,updated INT(1))""");


  }
  Future<int> create(String table,dynamic param) async {
    Database db = await database;
    var result = await db.insert(table,param);
    print("db service");
    print(result);
    return result;
  }

  Future<dynamic> read(dynamic param) async {
    Database db = await database;
    List<Map> results = await db.rawQuery('SELECT * FROM tbl_countsheet');

    if (results.length > 0) {
      return results;
    }

    return null;
  }
  Future<int> update(dynamic param) async {
    Database db = await database;
    
    return await db.rawUpdate('');
  
  
 
  }
  Future<int> delete(dynamic param) async {
    Database db = await database;
    
    return await db.rawDelete('');
  
  
 
  }




}

 