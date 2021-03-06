
import 'database.dart';
import '../../models/countsheet.dart';
class CountsheetDB{
  
  DatabaseService databaseService = DatabaseService.instance;
  
  Future<List<Map<String,dynamic>>> readCountSheet() async{
    List<Map<String,dynamic>> data = await databaseService.read("tbl_countsheet");
    return(data);
    
  }
  Future<dynamic> createCountsheet(countId,itemGroupName,parentGroupName,synced,syncedDate,updated) async{
    dynamic data =await databaseService.create("tbl_countsheet",Countsheet(countId:countId,itemGroupName:itemGroupName,parentGroupName:parentGroupName,synced:synced,syncedDate:syncedDate,updated:updated).toJson());
    
    return(data);
    
  }
  
}

