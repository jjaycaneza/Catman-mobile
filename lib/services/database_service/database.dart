import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' ;

class DatabaseService{
  
  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  Future<dynamic> _createDatabase() async{
    print("creating db");
    
    String databasePath = await getDatabasesPath();
    // deleteDatabase(join(databasePath,'gaisano_catman.db'));
    String dbPath = join(databasePath,'gaisano_catman.db');
    deleteDatabase(dbPath);
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
        count_id TEXT,parent_group_name TEXT,item_group_name TEXT,synced INTEGER,synced_date DATETIME,updated INTEGER)""");
    // """CREATE TABLE contact_groups(
    //     contact_id INTEGER,
    //     group_id INTEGER,
    //     PRIMARY KEY (contact_id, group_id),
    //     FOREIGN KEY (contact_id) 
    //         REFERENCES contacts (contact_id) 
    //           ON DELETE CASCADE 
    //           ON UPDATE NO ACTION,
    //     FOREIGN KEY (group_id) 
    //         REFERENCES groups (group_id) 
    //           ON DELETE CASCADE 
    //           ON UPDATE NO ACTION
    //   )"""
    await database.execute("""CREATE TABLE tbl_brands (
      brand_id INTEGER ,
      brand_name text DEFAULT NULL,
      brand_code INTEGER DEFAULT NULL,
      brand_desc text DEFAULT NULL,
      parent_group_id INTEGER DEFAULT NULL,
      PRIMARY KEY (brand_id),
      FOREIGN KEY (parent_group_id) REFERENCES tbl_parent_group (parent_group_id)
    )""");
    database.batch();
    dynamic res = await database.rawQuery("pragma table_info('tbl_brands')");
    print(res);

  }
  Future<int> create(String table,dynamic param) async {
    Database db = await database;
    var result = await db.insert(table,param);
    print("db service");
    print(result);
    return result;
  }

  Future<dynamic> read(String table) async {
    Database db = await database;
    List<Map<String,dynamic>> results = await db.query(table);

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

 