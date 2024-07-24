import 'package:amazon_clone/auth/auth_page.dart';
import 'package:amazon_clone/pages/search_screen.dart';
import 'package:amazon_clone/pages/sell_screen.dart';
import 'package:amazon_clone/utils/button.dart';
import 'package:amazon_clone/utils/home_items.dart';
import 'package:amazon_clone/utils/models.dart';
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
                      return ProductsShowcaseListView(title: "Your Orders ", children: children);
                    }
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: MyButton(
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SellScreen()));
                    },
                    text: "Sell"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: MyButton(ontap: signout, text: "Sign Out"),
              ),
            ],
          ),
          UserDetailsBar(
            offset: 0,
          )
        ]));
  }
}
