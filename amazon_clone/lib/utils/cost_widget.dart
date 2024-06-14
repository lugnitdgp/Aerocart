import 'package:flutter/material.dart';

class CostWidget extends StatelessWidget {
  final double cost;
  const CostWidget({super.key,required this.cost});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "₹",
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontFeatures: const [
              FontFeature.superscripts(),
            ],
          ),
        ),
        Text(
          cost.toInt().toString(),
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          (cost - cost.truncate()).toString(),
          style: TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}