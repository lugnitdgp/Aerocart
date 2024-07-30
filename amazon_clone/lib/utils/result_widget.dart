import 'package:amazon_clone/pages/product_screen.dart';
import 'package:amazon_clone/utils/cost_widget.dart';
import 'package:amazon_clone/utils/models.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final ProductModels product;
  const ResultWidget({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
              product: product
            ),
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: 149,
            child: Image.network(product.url[0]),
          ),
          Text(product.productname,maxLines: 3,overflow: TextOverflow.ellipsis,),
          CostWidget(cost: product.cost)
        ],
      ),
    );
  }
}