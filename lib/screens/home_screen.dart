
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


import '../services/api_service/user_api.dart';
import 'create_countsheet.dart';
import '../services/localstorage.dart';
import 'login_screen.dart';
class HomeScreen extends StatefulWidget {
  final String username;
  HomeScreen({Key key,this.username}):super(key:key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserApi _userApi = UserApi();
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
  


  Future<dynamic> getCountsheet() async{
    dynamic response = await _userApi.getCountsheet();
    setState(() {
      countsheet = response;
    });
    // print(countsheet);
  }
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
        title: Text('Homepage'),
      ),
      body:ListView.builder(
        itemCount: countsheet.length,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 80,    
                  ),
                  Text(widget.username ?? "")
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
             FlatButton(
              child: Text("Barcode Scanner",textAlign:TextAlign.left,),
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
            FlatButton(
              child: Text("QR Scanner",textAlign:TextAlign.left,),
              onPressed: (){
               
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
            FlatButton(
              child: Text("Barcode Scan Stream",textAlign:TextAlign.left,),
              onPressed: (){
                
                startBarcodeScanStream();
               
              },
            ),
            FlatButton(
              child: Text("Logout"),
              onPressed: (){
                LocalstorageService().logout();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>LoginScreen()));
               
              },
            )
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