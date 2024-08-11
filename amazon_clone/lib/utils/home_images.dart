import 'package:amazon_clone/pages/product_screen.dart';
import 'package:amazon_clone/utils/models.dart';
import 'package:flutter/material.dart';

class HomeImages extends StatelessWidget {
  final ProductModels product;
  const HomeImages({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
              product: product,
            ),
          ),
        );
      },
      child: Image.network(product.url[0],),
    );
  }
}