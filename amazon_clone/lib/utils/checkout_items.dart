import 'package:amazon_clone/utils/models.dart';
import 'package:flutter/material.dart';

class CheckoutItems extends StatelessWidget {
  final ProductModels product;
  const CheckoutItems({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          border: const BorderDirectional(bottom: BorderSide(width: 0.5))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ("${product.productname}(${product.quantity})"),
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              product.cost.toString(),
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
