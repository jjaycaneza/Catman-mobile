

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

createDatabase() async{
  String databasePath = await getDatabasesPath();
  String dbPath = join(databasePath,'gaisano_catman.db');
  var database = await openDatabase(dbPath,version:1,onCreate:populateDB);
  return database;
}


void populateDB(Database database,int version) async{
  await database.execute("""CREATE TABLE tbl_countsheet (countsheet_id PRIMARY KEY TEXT,
      count_id TEXT,parent_group_name TEXT,item_group_name TEXT,synced INT(1),synced_date DATETIME,updated INT(1))""");


}

 