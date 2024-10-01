import 'package:flutter/material.dart';

class MyButton extends StatelessWidget  {
  final Function ()? ontap;
  final String text;
  const MyButton({super.key ,required this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          height: 50,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 253, 178, 17),
            borderRadius: BorderRadius.circular(10) 
          ),
          child:Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ),
    );
  }
}