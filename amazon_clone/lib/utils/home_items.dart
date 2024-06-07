import 'package:flutter/material.dart';

class HomeItems extends StatelessWidget {
  const HomeItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.network("https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png")],
              ),
              flex: 5,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Item",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)], 
              ),
              flex: 1,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("₹ 100",style: TextStyle(fontSize: 16),)],
              ),
              flex: 1,
            )
          ],
        ),
    );
  }
}