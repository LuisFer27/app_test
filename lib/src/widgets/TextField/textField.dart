import 'package:flutter/material.dart';

class TextField extends StatelessWidget {
const TextField({
  super.key,
  required this.hintText,
  required this.onChanged, 
  required InputDecoration decoration
  }
  );
final String hintText;
final void Function(String) onChanged;
@override
Widget build(BuildContext context){
  return  TextField(
  onChanged: onChanged,
  decoration: InputDecoration(
    hintText: hintText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 2,
      ),
    ),
  ), hintText: '',
);
}
}