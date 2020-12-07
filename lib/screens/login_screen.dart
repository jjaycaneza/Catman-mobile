
import 'package:flutter/material.dart';
import 'package:gaisano_catman/screens/home_screen.dart';
import 'package:gaisano_catman/services/localstorage.dart';

import '../services/api_service/user_api.dart';
import '../widgets/rounded_input.dart';
class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
 

  @override
  _LoginScreenState createState() => _LoginScreenState();
}




class _LoginScreenState extends State<LoginScreen> {
  
  UserApi _userApi =  UserApi();
  String curUser = "";
  Future<void> _showMyDialog() async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No matched User.'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Incorrect username or password. Please try again.')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Future<void> setCurrentUser(username,password) async{
   
    LocalstorageService _userLocalstorage = LocalstorageService();
    await _userLocalstorage.set(username,password);
    setState(() {
      curUser = username;
    });
    
  }

  Future<dynamic> signIn(String username,String password) async{
    try{
      dynamic userData = await _userApi.signin(username, password);
    
      _scaffoldKey.currentState.hideCurrentSnackBar();
      if(userData != null){
        
        setCurrentUser(userData['username'],userData['password']);
        
        Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (_)=>HomeScreen(username: curUser,)));
      }else{

        _showMyDialog();
        
      }
      
    }catch(e){
      print(e);
    }
    
   
  }

  final GlobalKey<FormState> _userForm = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();



  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose(){
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  

  
  @override
  Widget build(BuildContext context) {
   
    return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Form(
        key:_userForm,
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundedInput(
              name: "Username",
              isPassword: false,
              controller: _username,
              validator: (String val){
                if(val.isEmpty) return "This field is required";
                return null;
              }
            ),
            RoundedInput(
              name: "Password",
              isPassword: true,
              controller: _password,
              validator: (String val){
                if(val.isEmpty) return "This field is required";
                return null;
              }
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.send),
                    Text("Sign In")
                  ],
                ),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: ()=>{
                  if(_userForm.currentState.validate()){
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content:Row(
                          children: <Widget>[
                            new CircularProgressIndicator(),
                            new Text("  Signing-In...")
                          ],
                        )
                      )
                    ),
                  
                    signIn(_username.text,_password.text) 
                  }
                  
                }
              ),
            )

            
          ],
        ),
      ),  
    );
    
  }
  
}