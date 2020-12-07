import 'database.dart';

import 'dart:convert';
class CountsheetDB{
  
  DatabaseService databaseService = DatabaseService.instance;
  
  Future<dynamic> test() async{
    dynamic data =await databaseService.read("param");
    
    return(json.encode(data));
    
  }
  
}