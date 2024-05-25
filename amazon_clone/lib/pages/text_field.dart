import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {  
  final controller;
  final String hintText;
  final bool obstext;

  const Textfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obstext,
    });



  @override
  Widget build(BuildContext context) {
    return Padding(
             padding: EdgeInsets.fromLTRB(20,5,20,0),
             child: TextField(
              controller: controller,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey)
                ),
                fillColor: Colors.blueGrey[50],
                filled: true,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey)
              ),
              obscureText: obstext,
             ),
           );
  }
}