import 'package:amazon_clone/auth/auth_page.dart';
import 'package:amazon_clone/layout/screen_layout.dart';
import 'package:amazon_clone/pages/order_requests.dart';
import 'package:amazon_clone/pages/profile.dart';
import 'package:amazon_clone/pages/search_screen.dart';
import 'package:amazon_clone/pages/wishlist.dart';
import 'package:amazon_clone/pages/your_orders.dart';
import 'package:amazon_clone/utils/menu_tile.dart';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/user_details_model.dart';
import '../provider/user_details_provider.dart';
import '../utils/user_details_bar.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? userStream;

  @override
  void initState() {
    super.initState();
    userStream = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("orderRequests")
        .snapshots();
  }

  void signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return const AuthPage();
      },
    ), (route) => false);
  }

  final AsyncMemoizer<QuerySnapshot<Map<String, dynamic>>> memoizer =
      AsyncMemoizer();

  Future<QuerySnapshot<Map<String, dynamic>>> fetchData() {
    return memoizer.runOnce(() async {
      return await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .get();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userdetails;
    final MQ = MediaQuery.of(context).size;
    double height = MQ.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, height / 11),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 168, 202, 127),
                Color.fromARGB(255, 37, 46, 42)
              ],
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
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                            builder: (context) {
                              return const ScreenLayout();
                            },
                          ), (route) => false);
                        },
                        child: Image.asset(
                          'lib/images/amazon.png',
                          height: 80,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_none_outlined,
                              size: 28,
                              color: Color.fromARGB(255, 255, 253, 240),
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
                            color: Color.fromARGB(255, 255, 253, 240),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ]),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16.0,
              left: 10.0,
              right: 10.0,
              bottom: 10.0,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 168, 202, 127),
                  Color.fromARGB(255, 37, 46, 42)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 5, bottom: 5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MQ.height * 0.08,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 30,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MQ.height * 0.02,
                            horizontal: MQ.width * 0.03),
                        child: Text('Hello, ${userDetailsModel.name}!',
                            style: TextStyle(
                              fontSize: MQ.width * 0.06,
                              color: Colors.black87,
                            )),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: MQ.height * 0.67,
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        primary: false,
                        slivers: <Widget>[
                          SliverPadding(
                            padding:EdgeInsets.symmetric(vertical:MQ.height*0.015,horizontal: MQ.width*0.01),
                            sliver: SliverGrid.count(
                              crossAxisSpacing: MQ.width * 0.03,
                              mainAxisSpacing:MQ.height*0.015,
                              crossAxisCount: 2,
                              children: <Widget>[
                                MenuTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const UserProfile(),
                                      ),
                                    );
                                  },
                                  image: 'lib/images/profile5.jpg',
                                  child: Text('Your Account',
                                      style: TextStyle(
                                        fontSize: MQ.width * 0.04,
                                      )),
                                ),
                                MenuTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const YourOrders(),
                                      ),
                                    );
                                  },
                                  image: 'lib/images/orders3.jpg',
                                  child: Text('Your orders',
                                      style: TextStyle(
                                        fontSize: MQ.width * 0.04,
                                      )),
                                ),
                                MenuTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Wishlist(),
                                      ),
                                    );
                                  },
                                  image: 'lib/images/wis.webp',
                                  child: Text('Wishlist',
                                      style: TextStyle(
                                        fontSize: MQ.width * 0.04,
                                      )),
                                ),
                                MenuTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Wishlist(),
                                      ),
                                    );
                                  },
                                  image: 'lib/images/credit-card2.webp',
                                  child: Text('Payment Methods',
                                      style: TextStyle(
                                        fontSize: MQ.width * 0.04,
                                      )),
                                ),
                                MenuTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const OrderRequests(),
                                      ),
                                    );
                                  },
                                  image: 'lib/images/order-requests.png',
                                  child: Text('Order Requests',
                                      style: TextStyle(
                                        fontSize: MQ.width * 0.04,
                                      )),
                                ),
                                MenuTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Wishlist(),
                                      ),
                                    );
                                  },
                                  image: 'lib/images/gear.webp',
                                  child: Text('Settings',
                                      style: TextStyle(
                                        fontSize: MQ.width * 0.04,
                                      )),
                                ),
                                MenuTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Wishlist(),
                                      ),
                                    );
                                  },
                                  image: 'lib/images/customer-service.webp',
                                  child: Text('Customer Service',
                                      style: TextStyle(
                                        fontSize: MQ.width * 0.04,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          UserDetailsBar(
            offset: 0,
          )
        ],
      ),
    );
  }
}
