import 'package:flutter/material.dart';
import 'package:gaisano_catman/widgets/rounded_input.dart';
import '../services/database_service/countsheet_db.dart';
class CreateCountsheet extends StatefulWidget {
  @override
  _CreateCountsheetState createState() => _CreateCountsheetState();
}

class _CreateCountsheetState extends State<CreateCountsheet> {

  TextEditingController _parentGroup = TextEditingController();
  TextEditingController _itemGroup = TextEditingController();
  void addCountsheet() async{
    CountsheetDB _countsheetDB = CountsheetDB();
    dynamic res = await _countsheetDB.createCountsheet();
    print("naa sa screen gyud");
    print(res);
  }
 
  @override
  void initState(){
    
    super.initState();

    addCountsheet();
   
    
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
              initialValue: "sdfsf",
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