import 'package:amazon_clone/utils/product_info.dart';
import 'package:flutter/material.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(3, 8, 3, 8),
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(
              bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 120,
                      child: Image.network(
                          "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png"),
                    ),
                  ],
                ),
                const ProductInfo(
                    productName: "Something very good ",
                    cost: 10000,
                    sellerName: "Seller"),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 150,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.delete_outlined)),
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
