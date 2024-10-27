import 'package:amazon_clone/auth/user_details_model.dart';
import 'package:amazon_clone/login_screens/user_details.dart';
import 'package:amazon_clone/pages/results_screen.dart';
import 'package:amazon_clone/provider/user_details_provider.dart';
import 'package:amazon_clone/cloud_firestore_methods/cloud_firestore.dart';
import 'package:amazon_clone/utils/cost_widget.dart';
import 'package:amazon_clone/utils/custom_simple_rounded_button.dart';
import 'package:amazon_clone/utils/home_items.dart';
import 'package:amazon_clone/utils/item_carousel.dart';
import 'package:amazon_clone/utils/loading_widget.dart';
import 'package:amazon_clone/models/models.dart';
import 'package:amazon_clone/utils/product_showcase_list_view.dart';
import 'package:amazon_clone/utils/rating_star_widget.dart';
import 'package:amazon_clone/utils/review_dialog.dart';
import 'package:amazon_clone/models/review_model.dart';
import 'package:amazon_clone/utils/review_widget.dart';
import 'package:amazon_clone/utils/user_details_bar.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class ProductScreen extends StatefulWidget {
  final ProductModels product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final AsyncMemoizer<QuerySnapshot<Map<String, dynamic>>> _memoizer =
      AsyncMemoizer();
  final AsyncMemoizer<QuerySnapshot<Map<String, dynamic>>> memoizer =
      AsyncMemoizer();
  bool showMore = false;
  Future<QuerySnapshot<Map<String, dynamic>>> _fetchData() {
    return _memoizer.runOnce(() async {
      return await FirebaseFirestore.instance
          .collection("products")
          .where("category", isEqualTo: widget.product.category)
          .get();
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchData() {
    return memoizer.runOnce(() async {
      return await FirebaseFirestore.instance
          .collection("products")
          .where("category", isEqualTo: widget.product.category)
          .get();
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? userStream;

  @override
  void initState() {
    super.initState();
    getImages(widget.product);
    userStream = FirebaseFirestore.instance
        .collection("products")
        .doc(widget.product.uid)
        .collection("reviews")
        .snapshots();
  }

  List<Widget> myitems = [];
  void getImages(ProductModels model) {
    for (int i = 0; i < model.url.length; i++) {
      myitems.add(
        Image.network(model.url[i]),
      );
    }
  }

  int reviewCount = 0;

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userdetails;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.fromLTRB(width * 0.077, 0, 0, 10),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 4),
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: width / 2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: Text.rich(
                        TextSpan(children: [
                          const TextSpan(
                            text: "Total: ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          const TextSpan(
                            text: " ₹",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: widget.product.cost.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await CloudFirestoreClass()
                        .addProducttoCart(model: widget.product);
                    Utils().showSnackBar(
                        context: context, content: "Added to Cart");
                  },
                  child: Container(
                    height: 53,
                    width: width / 3,
                    decoration: BoxDecoration(
                        border: const Border(
                            left: BorderSide(color: Colors.black, width: 5)),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(40)),
                    child: const Center(
                        child: Text(
                      "Add to Cart",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
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
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: TextField(
                          onSubmitted: (String querry) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ResultsScreen(querry: querry),
                              ),
                            );
                          },
                          decoration: InputDecoration(
                            isCollapsed: true,
                            isDense: true,
                            contentPadding: const EdgeInsets.all(11),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                              fontSize: 17,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: 30,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ]),
          ),
        ),
        backgroundColor: Colors.blueGrey[50],
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                        child: Stack(children: [
                          Container(
                            width: width - 10,
                            height: MediaQuery.of(context).size.height / 3.1,
                            constraints: const BoxConstraints(maxHeight: 320),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 25),
                              child: ItemCarousel(myitemss: myitems),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: (){},
                                icon: const Icon(Icons.share)),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product.productname,
                                    maxLines: 10,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22),
                                  ),
                                  Row(
                                    children: [
                                      RatingStatWidget(
                                          rating: widget.product.rating),
                                      Text(
                                          "(${reviewCount.toString()} Reviews)"),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CostWidget(cost: widget.product.cost),
                                    Text.rich(
                                      TextSpan(children: [
                                        const TextSpan(text: "Seller:"),
                                        TextSpan(
                                          text: widget.product.sellername,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: width * 0.3,
                                height: 37,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showMore = !showMore;
                                    });
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: showMore
                                          ? widget.product.description
                                          : widget.product.description.substring(
                                              0,
                                              100), // Adjust this number for truncation length
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                      children: [
                                        if (!showMore &&
                                            widget.product.description.length >
                                                100)
                                          const TextSpan(
                                            text: " ... See More",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        if (showMore)
                                          const TextSpan(
                                            text: " Show Less",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: _fetchData(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LoadingWidget();
                            } else {
                              List<Widget> children = [];
                              for (int i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                ProductModels model =
                                    ProductModels.getModelFromJson(
                                        json: snapshot.data!.docs[i].data());
                                if (model.uid == widget.product.uid) {
                                  continue;
                                } else {
                                  children.add(HomeItems(productModels: model));
                                }
                              }
                              return ProductsShowcaseListView(
                                  title: "Similar Items ", children: children);
                            }
                          }),
                      CustomSimpleRoundedButton(
                          text: "Add review for this product",
                          onPressed: () {
                            if (userDetailsModel.name == "loading" ||
                                userDetailsModel.name == "loading") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UserDetails(),
                                ),
                              );
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => ReviewDialog(
                                        productUid: widget.product.uid,
                                      ));
                            }
                          }),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: StreamBuilder(
                                stream: userStream,
                                builder: (context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container();
                                  } else {
                                    reviewCount = snapshot.data!.docs.length;
                                    return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          ReviewModel model =
                                              ReviewModel.getModelFromJson(
                                                  json: snapshot
                                                      .data!.docs[index]
                                                      .data());
                                          return ReviewWidget(review: model);
                                        });
                                  }
                                },
                              ))),
                      const SizedBox(
                        height: 90,
                      )
                    ],
                  )
                ],
              ),
            ),
            UserDetailsBar(
              offset: 0,
            ),
          ],
        ),
      ),
    );
  }
}