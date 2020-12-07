
import 'dart:convert';

// import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalstorageService{
  // final LocalStorage localstorage = new LocalStorage('gaisano.json');
  Future<Map<String,dynamic>> get() async {
   
    // dynamic response = await localstorage.getItem("user_data");
    
    // if(response != null){
    //   print("naa sa if");
    //   print(response);
    //   return User.fromJson(response);
    // }else{
    //   print("nasa else");
    //   return new User(username: "",password: "");
    // }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.get("username");
    String password = prefs.get("password");

    if(username != null || password != null){
      return json.decode('{"username":"$username","password":"$password","logged_in":true}');
    }else{
       return json.decode('{"username":"","password":"","logged_in":false}');
    }
    
    
  }
  Future<void> set(username,password) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await localstorage.setItem("user_data",json.decode('{"username": "$uname","password":"$pwd"}' ));
    print("nag set");
    
    prefs.setString("username",username);
    prefs.setString("password",password);


  }

  void logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
  }
 

}
