import 'package:amazon_clone/utils/cloud_firestore.dart';
import 'package:amazon_clone/utils/loading_widget.dart';
import 'package:amazon_clone/utils/products_showcase.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatefulWidget {
  final String querry;
  const ResultsScreen({super.key, required this.querry});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late String name = widget.querry;
  List<Widget>? product;

  @override
  void initState() {
    getData(widget.querry);
    super.initState();
  }

  void getData(querry) async {
    List<Widget>? temp =
        await CloudFirestoreClass().searchProducts(name: querry);
    setState(() {
      product = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
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
                        onSubmitted: (value) {
                          getData(value);
                          setState(() {
                            name = value;
                          });
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
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                  ),
                ]),
          ]),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                      text: "Search results for ",
                      style: TextStyle(fontSize: 17, color: Colors.black)),
                  TextSpan(
                    text: "'$name'",
                    style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: CloudFirestoreClass().searchProducts(name: name),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Widget?>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                } else if (snapshot.data == []) {
                  return Center(
                    child: SizedBox(
                      height: 100,
                      width: width,
                      child: Text(
                        "Oops nothing found with the name $name",
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  );
                } else {
                  return ProductsShowcase(children: product!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
