import 'package:flutter/material.dart';

class CustomSquareButton extends StatelessWidget {  
  final VoidCallback onpressed;
  final double dimension;
  final Widget child;
  const CustomSquareButton({super.key,required this.onpressed,required this.dimension,required this.child,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: dimension,
        width: dimension,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey,width: 1,
            ),
            borderRadius: BorderRadius.circular(20)
          )
        ),
        child: Center(child: child),
      ),
    );
  }
}