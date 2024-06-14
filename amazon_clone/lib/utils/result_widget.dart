import 'package:amazon_clone/utils/cost_widget.dart';
import 'package:amazon_clone/utils/models.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final ProductModels product;
  const ResultWidget({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          SizedBox(
            child: Image.network(product.url),
          ),
          Text(product.productname,maxLines: 3,overflow: TextOverflow.ellipsis,),
          CostWidget(cost: product.cost)
        ],
      ),
    );
  }
}