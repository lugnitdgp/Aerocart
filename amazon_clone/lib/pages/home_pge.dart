import 'package:amazon_clone/utils/carousel.dart';
import 'package:amazon_clone/utils/categories.dart';
import 'package:amazon_clone/utils/home_items.dart';
import 'package:amazon_clone/pages/search_screen.dart';
import 'package:amazon_clone/utils/user_details_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double offset = 0;
  ScrollController scrollController = ScrollController();
  final search = TextEditingController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        offset = scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = width ~/ 180;
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
                            builder: (context) => SearchScreen()));
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
      backgroundColor: Colors.blueGrey[50],
      body: Stack(children: [
        SingleChildScrollView(
          controller: scrollController,
          child: Column(children: [
            const SizedBox(
              height: 40,
              width: double.infinity,
            ),
            const CategoriesBar(),
            const ImageCarousel(),
            const Text(
              "Recomended Items",
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                ),
                itemBuilder: (context, index) {
                  return const Padding(
                      padding: EdgeInsets.all(8.0), child: HomeItems());
                },
              ),
            ),
          ]),
        ),
        UserDetailsBar(
          offset: offset,
        )
      ]),
    );
  }
}
