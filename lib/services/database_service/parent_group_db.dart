import 'database.dart';

class ParengGroupDB{
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<List<Map<String,dynamic>>> readParentGroup() async{
    dynamic response = await databaseHelper.read('tbl_parent_group');
    return response;

  }

}