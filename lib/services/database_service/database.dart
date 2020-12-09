import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' ;

class DatabaseHelper{
  
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

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

    Batch batch = database.batch();
    batch.execute("DROP TABLE IF EXISTS tbl_countsheet");
    batch.execute("""CREATE TABLE tbl_countsheet (countsheet_id INTEGER PRIMARY KEY  AUTOINCREMENT,
        count_id TEXT,parent_group_name TEXT,item_group_name TEXT,synced INTEGER,synced_date DATETIME,updated INTEGER)""");
    batch.execute("DROP TABLE IF EXISTS tbl_brands");
    batch.execute("""CREATE TABLE tbl_brands (
      brand_id INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,
      brand_name text DEFAULT NULL,
      brand_code INTEGER DEFAULT NULL,
      brand_desc text DEFAULT NULL,
      parent_group_id INTEGER DEFAULT NULL,
      FOREIGN KEY (parent_group_id) REFERENCES tbl_parent_group (parent_group_id)
    )""");
    batch.execute("DROP TABLE IF EXISTS tbl_color");
    batch.execute("""CREATE TABLE tbl_color (
      color_id INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL,
      color_name text DEFAULT NULL,
      color_code INTEGER DEFAULT NULL,
      color_desc text DEFAULT NULL,
      item_group_id INTEGER DEFAULT NULL,
      FOREIGN KEY (item_group_id) REFERENCES tbl_item_group (item_group_id)
    )""");
    batch.execute("DROP TABLE IF EXISTS tbl_item_category");
    batch.execute("""CREATE TABLE tbl_item_category (
      item_category_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      item_category_name text DEFAULT NULL,
      item_category_code INTEGER DEFAULT NULL,
      item_category_desc text DEFAULT NULL,
      item_group_id INTEGER DEFAULT NULL,
      FOREIGN KEY (item_group_id) REFERENCES tbl_item_group (item_group_id)
    )""");
    batch.execute("DROP TABLE IF EXISTS tbl_item_form");
    batch.execute("""CREATE TABLE tbl_item_form (
      item_form_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      item_form_name text DEFAULT NULL,
      item_form_code INTEGER DEFAULT NULL,
      item_form_desc text DEFAULT NULL,
      item_category_id INTEGER DEFAULT NULL,
      FOREIGN KEY (item_category_id) REFERENCES tbl_item_category (item_category_id)
    )""");
    batch.execute("DROP TABLE IF EXISTS tbl_item_group");
    batch.execute("""CREATE TABLE tbl_item_group (
      item_group_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      item_group_name text DEFAULT NULL,
      item_group_code INTEGER DEFAULT NULL,
      item_group_desc text DEFAULT NULL,
      parent_group_id INTEGER DEFAULT NULL,
      FOREIGN KEY (parent_group_id) REFERENCES tbl_parent_group (parent_group_id)
    )""");
    batch.execute("DROP TABLE IF EXISTS tbl_item_subform");
    batch.execute("""CREATE TABLE tbl_item_subform (
      item_subform_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      item_subform_name text DEFAULT NULL,
      item_subform_code INTEGER DEFAULT NULL,
      item_subform_desc text DEFAULT NULL,
      item_form_id INTEGER DEFAULT NULL,
      FOREIGN KEY (item_form_id) REFERENCES tbl_item_form (item_form_id)
    )""");
    batch.execute("DROP TABLE IF EXISTS tbl_item_variant");
    batch.execute("""CREATE TABLE tbl_item_variant (
      item_variant_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      item_variant_name text DEFAULT NULL,
      item_variant_code INTEGER DEFAULT NULL,
      item_variant_desc text DEFAULT NULL,
      item_subform_id INTEGER DEFAULT NULL,
      FOREIGN KEY (item_subform_id) REFERENCES tbl_item_subform (item_subform_id)
    )""");
    batch.execute("DROP TABLE IF EXISTS tbl_parent_group");
    batch.execute("""CREATE TABLE tbl_parent_group (
      parent_group_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      parent_group_name text DEFAULT NULL,
      parent_group_code INTEGER DEFAULT NULL
    )""");
    batch.execute("DROP TABLE IF EXISTS tbl_size");
    batch.execute("""CREATE TABLE tbl_size (
      size_id INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT,
      size_name text DEFAULT NULL,
      size_code INTEGER DEFAULT NULL,
      size_desc text DEFAULT NULL,
      item_group_id INTEGER DEFAULT NULL,
      FOREIGN KEY (`item_group_id`) REFERENCES tbl_item_group (item_group_id)
    )""");
    await batch.commit(noResult:true);
    dynamic res = await database.rawQuery("pragma table_info('tbl_size')");
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

 