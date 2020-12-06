import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  final String name;
  final Function(String) validator;
  final bool isPassword;
  final TextEditingController controller;

  const RoundedInput({Key key, this.name, this.validator, this.isPassword, this.controller}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: EdgeInsets.all(16.0),
      child: TextFormField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          hintText: name,
          labelText: name
        ),
        validator: validator,
      ),
    );
  }
}