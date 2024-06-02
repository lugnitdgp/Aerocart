
import 'package:amazon_clone/utils/product_widget.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key,});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 160,
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text("Your Orders",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              ),
              Text("Show More",style: TextStyle(color: Colors.blue),),              
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SimpleProduct(url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png"),
                SimpleProduct(url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png"),
                SimpleProduct(url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png"),
                SimpleProduct(url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png"),
                SimpleProduct(url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png"),

              ],
            ),

          )
        ],
      ),
    );
  }
}