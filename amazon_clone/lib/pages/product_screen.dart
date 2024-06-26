import 'package:amazon_clone/pages/results_screen.dart';
import 'package:amazon_clone/utils/cost_widget.dart';
import 'package:amazon_clone/utils/models.dart';
import 'package:amazon_clone/utils/user_details_bar.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final ProductModels product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
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
                  onTap: () {},
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
                colors: [Colors.cyanAccent, Colors.greenAccent],
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
                            height: 320,
                            width: width - 10,
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height / 3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 25),
                              child: Image.network(widget.product.url),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.share)),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.productname,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 22),
                              ),
                              Row(
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
                                child: Text(
                                  widget.product.description,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
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
