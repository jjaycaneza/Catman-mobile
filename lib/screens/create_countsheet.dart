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

  String _parentGroup = "One";
  String _itemGroup = "";
  String _itemCategory = "";
  String _itemForm = "";
  String _brand = "";
  String _itemSubForm = "";
  String _variant = "";
  String _itemSize = "";
  String _itemColor = "";
  TextEditingController _physicalLocation = TextEditingController();
  TextEditingController _stockNo = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _otherBrand = TextEditingController();
  TextEditingController _otherItemForm = TextEditingController();
  TextEditingController _otherItemSubForm = TextEditingController();
  TextEditingController _otherVariant = TextEditingController();
  TextEditingController _otherItemSize = TextEditingController();
  TextEditingController _otherItemColor = TextEditingController();
  TextEditingController _itemDescription = TextEditingController();
  TextEditingController _auditRemarks = TextEditingController();


  String _countId = "";
  CountsheetDB _countsheetDB = CountsheetDB();
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  void addCountsheet() async{
    
    dynamic res = await _countsheetDB.createCountsheet(_countId,_itemGroup,_parentGroup,0,DateTime.now().toString(),0);
    
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
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                name:"Physical Location",
                
                controller:_physicalLocation ,
                validator: (val){},
                isPassword: false,
              ),
              RoundedInput(
                name:"Stock No",
                
                controller:_stockNo ,
                validator: (val){},
                isPassword: false,
              ),
              RoundedInput(
                name:"Price",
                
                controller:_price ,
                validator: (val){},
                isPassword: false,
              ),
              // RoundedInput(
              //   name:"Parent Group",
                
              //   controller:_parentGroup ,
              //   validator: (val){},
              //   isPassword: false,
              // ),
              Container(child: Text("Parent Group",),alignment:Alignment.centerLeft,padding: EdgeInsets.only(left:16),),
              Padding(
                padding: EdgeInsets.all(0),
                  child: Container(
                    padding: EdgeInsets.only(left: 20,right: 25),
                  
                    child: DropdownButton<String>(
                      hint: Text("hint"),
                      value: _parentGroup,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                      onChanged: (String newValue) {
                        setState(() {
                          _parentGroup = newValue;
                          print(_parentGroup);
                        });
                      },
                      items:  <dynamic>['One', 'Two', 'Free', 'Four']
                          .map<DropdownMenuItem<String>>((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
              ),
              // RoundedInput(
              //   name:"Item Group",
              //   controller:_itemGroup ,
              //   validator: (val){},
              //   isPassword: false,
              // ),
              // RoundedInput(
              //   name:"Brand",
                
              //   controller:_brand ,
              //   validator: (val){},
              //   isPassword: false,
              // ),
              RoundedInput(
                name:"Other Brand",
                
                controller:_otherBrand ,
                validator: (val){},
                isPassword: false,
              ),
              // RoundedInput(
              //   name:"Item Category",
                
              //   controller:_itemCategory ,
              //   validator: (val){},
              //   isPassword: false,
              // ),
              // RoundedInput(
              //   name:"Item Form",
                
              //   controller:_itemForm ,
              //   validator: (val){},
              //   isPassword: false,
              // ),
              RoundedInput(
                name:"Other Item Form",
                
                controller:_otherItemForm ,
                validator: (val){},
                isPassword: false,
              ),
              // RoundedInput(
              //   name:"Item Sub Form",
                
              //   controller:_itemSubForm,
              //   validator: (val){},
              //   isPassword: false,
              // ),
              RoundedInput(
                name:"Other Item Sub Form",
                
                controller:_otherItemSubForm,
                validator: (val){},
                isPassword: false,
              ),
              // RoundedInput(
              //   name:"Item Variant",
                
              //   controller:_variant,
              //   validator: (val){},
              //   isPassword: false,
              // ),
              RoundedInput(
                name:"Other Item Variant",
                
                controller:_otherVariant,
                validator: (val){},
                isPassword: false,
              ),
              // RoundedInput(
              //   name:"Item Size",
                
              //   controller:_itemSize,
              //   validator: (val){},
              //   isPassword: false,
              // ),
              RoundedInput(
                name:"Other Item Size",
                
                controller:_otherItemSize,
                validator: (val){},
                isPassword: false,
              ),
              // RoundedInput(
              //   name:"Item Color",
                
              //   controller:_itemColor,
              //   validator: (val){},
              //   isPassword: false,
              // ),
              RoundedInput(
                name:"Other Item Color",
                
                controller:_otherItemColor,
                validator: (val){},
                isPassword: false,
              ),
              RoundedInput(
                name:"Item Description",
                
                controller:_itemDescription,
                validator: (val){},
                isPassword: false,
              ),
              RoundedInput(
                name:"Audit Remarks",
                
                controller:_auditRemarks,
                validator: (val){},
                isPassword: false,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: (){
                    print(_parentGroup);
                    // addCountsheet();
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_)=> HomeScreen()));
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
      ),
    );
    
  }
}