import 'package:flutter/material.dart';
import 'package:gaisano_catman/screens/home_screen.dart';
import 'package:gaisano_catman/widgets/rounded_input.dart';
import '../services/database_service/countsheet_db.dart';
import 'dart:math';
class CreateCountsheet extends StatefulWidget {
  @override
  _CreateCountsheetState createState() => _CreateCountsheetState();
}

class _CreateCountsheetState extends State<CreateCountsheet> {

  TextEditingController _parentGroup = TextEditingController();
  TextEditingController _itemGroup = TextEditingController();
  String _countId = "";
  CountsheetDB _countsheetDB = CountsheetDB();
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  void addCountsheet() async{
    
    dynamic res = await _countsheetDB.createCountsheet(_countId,_itemGroup.text,_parentGroup.text,0,DateTime.now().toString(),0);
    
  }
 
  @override
  void initState(){
    
    super.initState();
    setState(() {
      _countId = getRandomString(10);
    });
   
   
    
  }
  @override
  Widget build(BuildContext context) {
   
    return  Scaffold(
      appBar: AppBar(
        title: Text("CountSheet")
      ),
      body: Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Count Id",
                labelText: "Count Id"
              ),
              initialValue: _countId,
              readOnly: true,
              enabled: false,
              
            
            ),
          ),
          RoundedInput(
            name:"Parent Group",
            
            controller:_parentGroup ,
            validator: (val){},
            isPassword: false,
          ),
          RoundedInput(
            name:"Item Group",
            controller:_itemGroup ,
            validator: (val){},
            isPassword: false,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: (){
                 addCountsheet();
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_)=> HomeScreen()));
              },
              color: Colors.blue,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Create")
              ],
                )
            ),
          )
        ]
      ),
      ),
    );
    
  }
}