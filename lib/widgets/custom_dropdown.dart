import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomDropdown extends StatefulWidget {

  String value;
  CustomDropdown({Key key,this.value}):super(key:key);
  
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 25),
        
          child: DropdownButton<String>(
            hint: Text("hint"),
            value: widget.value,
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
                widget.value = newValue;
                print(widget.value);
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
    );
  }
}