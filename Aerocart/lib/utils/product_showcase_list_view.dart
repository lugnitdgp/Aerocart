import 'package:amazon_clone/pages/show_more.dart';
import 'package:flutter/material.dart';

class ProductsShowcaseListView extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ProductsShowcaseListView({
    super.key, 
    required this.title,
    required this.children,
  }) ;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double titleHeight = 25;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      height: screenSize.height/4,
      width: screenSize.width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: titleHeight,
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowMore(products: children)));
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: Text(
                      "Show more",
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 190,
            width: screenSize.width,
            child:children.isNotEmpty? ListView(
              scrollDirection: Axis.horizontal,
              children: children,
            ):const Center(child: Text("Oops Nothing found!!",style: TextStyle(fontSize: 20),)),
          )
        ],
      ),
    );
  }
}