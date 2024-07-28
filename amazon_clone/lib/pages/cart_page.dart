import 'package:amazon_clone/auth/user_details_model.dart';
import 'package:amazon_clone/login_screens/user_details.dart';
import 'package:amazon_clone/pages/checkout_screen.dart';
import 'package:amazon_clone/provider/user_details_provider.dart';
import 'package:amazon_clone/utils/button.dart';
import 'package:amazon_clone/utils/cart_items.dart';
import 'package:amazon_clone/utils/cloud_firestore.dart';
import 'package:amazon_clone/utils/models.dart';
import 'package:amazon_clone/pages/search_screen.dart';
import 'package:amazon_clone/utils/user_details_bar.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
     Stream<QuerySnapshot<Map<String, dynamic>>>? userStream;


  @override
  void initState() {
    super.initState();
    userStream = FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("cart")
                  .snapshots();
  }


  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userdetails;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyanAccent, Colors.greenAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Image.asset(
                  'lib/images/amazon.png',
                  height: 35,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()));
                  },
                  child: Container(
                    width: width * 0.6,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.blueGrey, width: 2),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Search',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          ),
                          Icon(
                            Icons.search,
                            size: 28,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(children: [
        Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: MyButton(
                  ontap: () async {
                    bool a = await CloudFirestoreClass().isEmpty();
                    if (a) {
                      Utils().showSnackBar(
                          context: context, content: "Cart is Empty");
                    } else if (userDetailsModel.name == "loading" ||
                        userDetailsModel.address == "loading") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserDetails(),
                        ),
                      );
                    } else {
                      double cost = await CloudFirestoreClass().getTotalCost();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                            cost: cost,
                          ),
                        ),
                      );
                    }
                  },
                  text: "Proceed to buy"),
            ),
            Expanded(
                child: StreamBuilder(
              stream: userStream,
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text(
                      "No Items in Cart",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        ProductModels model = ProductModels.getModelFromJson(
                            json: snapshot.data!.docs[index].data());
                        return CartItems(product: model,onpressed: () async{
                            await CloudFirestoreClass().deleteFromCart(uid: model.uid);
                            setState(() {
                              
                            });
                            
                          },);
                      });
                }
              },
            )),
            const SizedBox(
              height: 180,
            )
          ],
        ),
        UserDetailsBar(
          offset: 0,
        )
      ]),
    );
  }
}
