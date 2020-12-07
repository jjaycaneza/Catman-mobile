import 'package:flutter/material.dart';
import 'package:gaisano_catman/screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'package:gaisano_catman/services/localstorage_service/localstorage.dart';
void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  String curUser = "";
  void getCurrentUser() async{
   
    LocalstorageService _userLocalstorage = LocalstorageService();
    Map<String,dynamic> response =  await _userLocalstorage.get();
    dynamic jsonResponse = response;

    setState(() {
      isLoggedIn = jsonResponse['logged_in'];
      curUser = jsonResponse['username'];
    });
    
  }
  
  @override
  void initState() {
    
    super.initState();
    getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
  
        primarySwatch: Colors.blue,
      
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (isLoggedIn) ? HomeScreen(username: curUser): LoginScreen() ,
    );
  }
}
