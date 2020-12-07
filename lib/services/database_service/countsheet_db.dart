import 'package:gaisano_catman/screens/create_countsheet.dart';

import 'database.dart';

import 'dart:convert';
import '../../models/countsheet.dart';
class CountsheetDB{
  
  DatabaseService databaseService = DatabaseService.instance;
  
  Future<dynamic> readCountSheet() async{
    dynamic data =await databaseService.read("param");
    Countsheet countsheet =  Countsheet(countId: "test",itemGroupName: "itemtest",parentGroupName: "parent",synced: 0,syncedDate: "01-02-2020",updated: 0);
    print("naa sa countsheet db");
    print(countsheet.toJson());
    return(data);
    
  }
  Future<dynamic> createCountsheet() async{
    dynamic data =await databaseService.create("tbl_countsheet",Countsheet(countId: "test",itemGroupName: "itemtest",parentGroupName: "parent",synced: 0,syncedDate: "01-02-2020",updated: 0).toJson());
    
    return(data);
    
  }
  
}



// class Customer {
//     int id;
//     String firstName;
//     String lastName;
//     String email;

//     Customer({
//         this.id,
//         this.firstName,
//         this.lastName,
//         this.email,
//     });

    

//     factory Customer.fromJson(Map<String, dynamic> data) => new Customer(
//         id: data["id"],
//         firstName: data["first_name"],
//         lastName: data["last_name"],
//         email: data["email"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//     };
// }