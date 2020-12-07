
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'api.dart';


class UserApi{
  
  Future<dynamic> signin(username,password) async {
    
    dynamic body = {
      'username':username,
      'password':password 
    };
    http.Response response = await http.post('${ApiDart.url}/users/signin',body:json.encode(body) ,headers: ApiDart.headers);
    print(response);
    if(response.statusCode != 200) throw response.statusCode ;
    return json.decode(response.body);
  }

  Future<dynamic> getCountsheet() async {
  
    http.Response response = await http.get('${ApiDart.url}/countsheet');
    var responseJson = json.decode(response.body);
    
    if(response.statusCode != 200 ) throw "Error";
   
    return responseJson ;
  }
}

