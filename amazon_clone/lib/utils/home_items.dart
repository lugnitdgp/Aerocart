import 'package:amazon_clone/pages/product_screen.dart';
import 'package:amazon_clone/utils/models.dart';
import 'package:flutter/material.dart';

class HomeItems extends StatelessWidget {
  const HomeItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
              product: ProductModels(
                  cost: 1000,
                  productname: "Wireless Headphones",
                  sellername: "Keshto",
                  selleruid: "zmjjkk",
                  uid: "2ku5",
                  url:"https://m.media-amazon.com/images/I/61PCZ2MuDBL._AC_UF1000,1000_QL80_.jpg",
                  description:"sodales ut etiam sit amet nisl purus in mollis nunc sed id semper risus in hendrerit gravida rutrum quisque non tellus orci ac auctor augue mauris augue neque gravida in fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum odio jsdfgnivdn fndfngo fnignfnof nognfodngnofgnofnognn nn nnognfgonfo gnofn no n gonfdognfodn non fognfo ngon nosfdngonffognsodfngonfo nsnfognodfsngonsfon ndsofgnosfndognsfodngo sofdgnosdfngonfong nfodgn osfdn gon ",

                      ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                      "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png")
                ],
              ),
              flex: 5,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Item",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              flex: 1,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "₹ 100",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
