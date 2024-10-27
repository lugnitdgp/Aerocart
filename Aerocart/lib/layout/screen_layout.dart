import 'package:amazon_clone/provider/user_details_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/pages/cart_page.dart';
import 'package:amazon_clone/pages/home_pge.dart';
import 'package:amazon_clone/pages/menu.dart';
import 'package:provider/provider.dart';

import '../provider/user_details_provider.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({super.key});

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  int currPage = 0;
  final List<Widget> tablist = [
    const HomePage(),
    const CartPage(),
    const Menu(),
  ];

  Stream<int> getCartItemCountStream() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  @override
  Widget build(BuildContext context) {
      Provider.of<UserDetailsProvider>(context).getData();
    return Scaffold(
      body: Stack(children: [
        tablist.elementAt(currPage),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: StreamBuilder<int>(
                stream: getCartItemCountStream(),
                builder: (context, snapshot) {
                  int cartItemCount = snapshot.data ?? 0;
                  return BottomNavigationBar(
                    selectedItemColor: const Color.fromARGB(255, 122, 207, 25),
                    unselectedItemColor: Colors.black,
                    backgroundColor: Colors.white,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    currentIndex: currPage,
                    onTap: (int page) {
                      setState(() {
                        currPage = page;
                      });
                    },
                    items: [
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Badge.count(
                          count: cartItemCount,
                          child: const Icon(Icons.shopping_cart_outlined),
                        ),
                        label: "Cart",
                      ),
                      const BottomNavigationBarItem(
<<<<<<< master
                        icon: Icon(Icons.menu),
                        label: "More",
=======
                        icon: Icon(Icons.account_circle_outlined),
                        label: "User",
>>>>>>> master
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }
}