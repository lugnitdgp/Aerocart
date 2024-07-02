import 'package:flutter/material.dart';

class ProductsShowcase extends StatefulWidget {
  final List<Widget> children;

  const ProductsShowcase({super.key, required this.children});

  @override
  State<ProductsShowcase> createState() => _ProductsShowcaseState();
}

class _ProductsShowcaseState extends State<ProductsShowcase> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = width ~/ 180;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount),
        children: widget.children,
      ),
    );
  }
}
