import 'package:amazon_clone/utils/cost_widget.dart';
import 'package:amazon_clone/utils/custom_square_button.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  final String productName;
  final double cost;
  final String sellerName;
  const ProductInfo(
      {super.key,
      required this.productName,
      required this.cost,
      required this.sellerName});

  @override
  Widget build(BuildContext context) {
    SizedBox spaceThingy = const SizedBox(
      height: 2,
    );
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              productName,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 0.9,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          spaceThingy,
          Align(
            alignment: Alignment.centerLeft,
            child: CostWidget(cost: cost),
          ),
          spaceThingy,
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "Sold by ",
                      style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                  TextSpan(
                      text: sellerName,
                      style: const TextStyle(
                          color: Colors.lightBlue, fontSize: 14)),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                CustomSquareButton(
                  onpressed: () {},
                  dimension: 30,
                  child: const Icon(Icons.remove,size: 20,),
                ),
                CustomSquareButton(
                  onpressed: () {},
                  dimension: 30,
                  child: Text("0",style: TextStyle(fontSize: 16,color: Colors.cyan.shade700),)
                ),                
                CustomSquareButton(
                  onpressed: () {},
                  dimension: 30,
                  child:  const Icon(Icons.add,size: 20,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
