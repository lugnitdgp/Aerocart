import 'package:amazon_clone/pages/product_screen.dart';
import 'package:amazon_clone/utils/models.dart';
import 'package:flutter/material.dart';

class HomeItems extends StatelessWidget {
  final ProductModels productModels;
  const HomeItems({super.key,required this.productModels});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
              product: productModels
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width/4,
          padding:const EdgeInsetsDirectional.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Image.network(productModels.url[0]))
                  ],
                ),
                
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(                      
                        child: Text(
                          productModels.productname,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                
              ),

              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      productModels.cost.toString(),
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
                
              )
            ],
          ),
        ),
      ),
    );
  }
}
