import 'package:amazon_clone/pages/product_screen.dart';
import 'package:amazon_clone/utils/models.dart';
import 'package:amazon_clone/utils/product_info.dart';
import 'package:flutter/material.dart';

class CartItems extends StatelessWidget {
  final ProductModels product;
  final VoidCallback onpressed;
  const CartItems({super.key, required this.product,required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(3, 8, 3, 8),
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: const Border(
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductScreen(product: product)));
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 120,
                        child: Image.network(product.url[0]),
                      ),
                    ),
                  ],
                ),
                ProductInfo(
                    productUid: product.uid,
                    productName: product.productname,
                    cost: product.cost,
                    sellerName: product.sellername,),
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
                          onPressed: onpressed , icon:const Icon(Icons.delete_outlined)),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
