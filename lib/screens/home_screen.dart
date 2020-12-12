
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'create_countsheet.dart';
import '../services/localstorage_service/localstorage.dart';
import 'login_screen.dart';
import '../models/countsheet.dart';
class HomeScreen extends StatefulWidget {
  final String username;
  HomeScreen({Key key,this.username}):super(key:key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // UserApi _userApi = UserApi();
  // CountsheetDB _countsheetDB = CountsheetDB();
  dynamic countsheet = [];

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _scanBarcode = 'Unknown';
  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    
  }
  


  // Future<dynamic> getCountsheet() async{
  //   dynamic response = await _userApi.getCountsheet();
  //   setState(() {
  //     countsheet = response;
  //   });
  //   // print(countsheet);
  // }
  Future<dynamic> getCountsheet() async{
    
    dynamic response = await Countsheet().readCountSheet();
    print(response);
    setState(() {
      countsheet = response;
    });
  }
  

  @override
  void initState() {
    super.initState();
    getCountsheet();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        title: Text('Count List'),
      ),
      body:ListView.builder(
        itemCount: countsheet != null ? countsheet.length:0 ,
        reverse: true,
        itemBuilder: (BuildContext context , int idx){
          return ListTile(
              title: Text(
                '${countsheet[idx]['count_id']}',
                style: TextStyle(fontSize: 18),
              ),
              leading: Text('${idx+1}'),
              
              onTap: (){
                print("open update");
              },
            );
        }
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          
          children: <Widget>[
            
            DrawerHeader(
              child:Text(""),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/logo.jpeg'),fit: BoxFit.cover,)),
            ),

            UserAccountsDrawerHeader( 
              
              margin: EdgeInsets.zero,
              accountName: Text(widget.username),  
              accountEmail: Text(""),  
              currentAccountPicture: CircleAvatar(
                
                backgroundColor: Colors.orange,  
                child: Text(
                  widget.username[0].toUpperCase(),  
                  style: TextStyle(fontSize: 40.0),  
                ),  
              ),  
            ),  
            ListTile(
              
                contentPadding: EdgeInsets.symmetric(horizontal: 8,),
                title: FlatButton(
                  child: Row(
                    
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                      Icon(Icons.camera),
                      Text("Barcode Scanner",textAlign:TextAlign.left)
                    ]
                  ),
                 
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    print("Open Scanner");
                    scanBarcodeNormal();

                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content:Row(
                              children: <Widget>[
                                new CircularProgressIndicator(),
                                new Text("Scanned: $_scanBarcode")
                              ],
                            ),
                      )
                    );
                 
                },
              ),
            ),
            ListTile(
              
              contentPadding: EdgeInsets.symmetric(horizontal: 8,),
              title: FlatButton(
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget>[
                    Icon(Icons.camera_alt),
                    Text("QR Scanner",textAlign:TextAlign.left)
                  ]
                ),
                
                padding: EdgeInsets.zero,
                onPressed: (){
                  print("Open Scanner");
                  scanQR();

                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content:Row(
                            children: <Widget>[
                              new CircularProgressIndicator(),
                              new Text("Scanned: $_scanBarcode")
                            ],
                          ),
                    )
                  );
                
                },
              ),
            ),
            ListTile(
            
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              title: FlatButton(
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget>[
                    Icon(Icons.exit_to_app),
                    Text("Logout",textAlign:TextAlign.left)
                  ]
                ),
                
                padding: EdgeInsets.zero,
                onPressed: (){
                  LocalstorageService().logout();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>LoginScreen()));
                },
              ),
            ),
            
          ],
        ),
      ),
      floatingActionButton: FlatButton(
        padding: EdgeInsets.all(8.6),
        
        child: Icon(Icons.add),
        
        onPressed: () { 
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CreateCountsheet()));
        },
      ),
    );
  }
}