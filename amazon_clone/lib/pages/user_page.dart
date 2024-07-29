import 'package:amazon_clone/auth/auth_page.dart';
import 'package:amazon_clone/pages/search_screen.dart';
import 'package:amazon_clone/pages/sell_screen.dart';
import 'package:amazon_clone/pages/seller_details_screen.dart';
import 'package:amazon_clone/utils/button.dart';
import 'package:amazon_clone/utils/cloud_firestore.dart';
import 'package:amazon_clone/utils/home_items.dart';
import 'package:amazon_clone/utils/models.dart';
import 'package:amazon_clone/utils/order_request_model.dart';
import 'package:amazon_clone/utils/product_showcase_list_view.dart';
import 'package:amazon_clone/utils/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  void signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return const AuthPage();
      },
    ), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 55),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyanAccent, Colors.greenAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
                        child: Image.asset(
                          'lib/images/Amazon_icon.png',
                          height: 50,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.notifications_none_outlined,
                                size: 28,
                              )),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SearchScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ]),
          ),
        ),
        body: Stack(children: [
          Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("orders")
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      List<Widget> children = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        ProductModels model = ProductModels.getModelFromJson(
                            json: snapshot.data!.docs[i].data());
                        children.add(HomeItems(productModels: model));
                      }
                      return snapshot.data != null
                          ? ProductsShowcaseListView(
                              title: "Your Orders ", children: children)
                          : const SizedBox(
                              height: 20,
                            );
                    }
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: MyButton(
                    ontap: () async {
                      bool t = await CloudFirestoreClass().isSeller();
                      if (t) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SellScreen(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SellerDetailsScreen(),
                          ),
                        );
                      }
                    },
                    text: "Sell"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: MyButton(ontap: signout, text: "Sign Out"),
              ),
                            const Padding(
                padding: EdgeInsets.all(15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Order Requests",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("orderRequests")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                OrderRequestModel model =
                                    OrderRequestModel.getModelFromJson(
                                        json:
                                            snapshot.data!.docs[index].data());
                                return ListTile(
                                  title: Text(
                                    "Order: ${model.orderName}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  subtitle:
                                      Text("Address: ${model.buyersAddress}"),
                                  trailing: IconButton(
                                      onPressed: () async {
                                        FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection("orderRequests")
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                      },
                                      icon: Icon(Icons.check)),
                                );
                              });
                        }
                      }))
            ],
          ),
          UserDetailsBar(
            offset: 0,
          )
        ]));
  }
}
