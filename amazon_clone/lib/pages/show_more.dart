import 'package:amazon_clone/pages/results_screen.dart';
import 'package:amazon_clone/utils/products_showcase.dart';
import 'package:flutter/material.dart';

class ShowMore extends StatefulWidget {
  final List<Widget> products;
  const ShowMore({super.key, required this.products});

  @override
  State<ShowMore> createState() => _ShowMoreState();
}

class _ShowMoreState extends State<ShowMore> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ResultsScreen(querry: value)));
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
              text: const TextSpan(
                children: [
                  TextSpan(
                      text: "More Items-",
                      style: TextStyle(fontSize: 17, color: Colors.black)),
                ],
              ),
            ),
          ),
          widget.products.isNotEmpty
              ? ProductsShowcase(children: widget.products)
              : SizedBox(
                  height: height / 2,
                  child: const Center(
                      child: Text(
                    "Oops!! Nothing here ",
                    style: TextStyle(fontSize: 20),
                  )),
                )
        ],
      ),
    );
  }
}
