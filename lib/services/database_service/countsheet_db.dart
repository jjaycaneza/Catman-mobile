import 'package:gaisano_catman/screens/create_countsheet.dart';

import 'database.dart';

import 'dart:convert';
import '../../models/countsheet.dart';
class CountsheetDB{
  
  DatabaseService databaseService = DatabaseService.instance;
  
  Future<dynamic> readCountSheet() async{
    dynamic data =await databaseService.read("param");
    Countsheet countsheet =  Countsheet(countId: "test",itemGroupName: "itemtest",parentGroupName: "parent",synced: 0,syncedDate: "01-02-2020",updated: 0);
   
    return(data);
    
  }
  Future<dynamic> createCountsheet(countId,itemGroupName,parentGroupName,synced,syncedDate,updated) async{
    dynamic data =await databaseService.create("tbl_countsheet",Countsheet(countId:countId,itemGroupName:itemGroupName,parentGroupName:parentGroupName,synced:synced,syncedDate:syncedDate,updated:updated).toJson());
    
    return(data);
    
  }
  
}

