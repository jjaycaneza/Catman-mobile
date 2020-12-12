import 'package:gaisano_catman/services/database_service/database.dart';

class Countsheet {
  // countsheet_id INTEGER PRIMARY KEY  AUTOINCREMENT,
  // count_id TEXT,
  // brand_id INTEGER DEFAULT NULL,
  // color_id INTEGER DEFAULT NULL,
  // item_category_id INTEGER DEFAULT NULL,
  // item_form_id INTEGER DEFAULT NULL,
  // item_group_id INTEGER DEFAULT NULL,
  // item_subform_id INTEGER DEFAULT NULL,
  // item_variant_id INTEGER DEFAULT NULL,
  // parent_group_id INTEGER DEFAULT NULL,
  // size_id INTEGER DEFAULT NULL,
  // synced INTEGER DEFAULT 0,
  // synced_date DATETIME DEFAULT NULL,
  // updated INTEGER DEFAULT 0,
  String itemGroupName;
  String parentGroupName;
  String countId;
  int synced;
  String syncedDate;
  int updated;
  Countsheet({this.itemGroupName, this.parentGroupName,this.countId,this.synced,this.syncedDate,this.updated});



  Countsheet.fromJson(Map<String,dynamic> json){
    itemGroupName = json['item_group_name'];
    parentGroupName = json['parent_group_name'];
    countId = json['count_id'];
    synced = json['synced'];
    syncedDate = json['syncedDate'];
    updated = json['updated'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    data['item_group_name'] = itemGroupName;
    data['parent_group_name'] = parentGroupName;
    data['count_id'] = countId;
    data['synced'] = synced;
    data['synced_date'] = syncedDate;
    data['updated'] = updated;

    return data;
  }
  
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  
  Future<List<Map<String,dynamic>>> readCountSheet() async{
    List<Map<String,dynamic>> data = await databaseHelper.read("tbl_countsheet");
    return(data);
    
  }
  Future<dynamic> createCountsheet(countId,itemGroupName,parentGroupName,synced,syncedDate,updated) async{
    dynamic data =await databaseHelper.create("tbl_countsheet",Countsheet(countId:countId,itemGroupName:itemGroupName,parentGroupName:parentGroupName,synced:synced,syncedDate:syncedDate,updated:updated).toJson());
    
    return(data);
    
  }

  
}