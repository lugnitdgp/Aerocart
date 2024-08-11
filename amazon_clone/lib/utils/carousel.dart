import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageCarousel extends StatefulWidget {
  final List<Widget> myitems;
  const ImageCarousel({super.key, required this.myitems});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

const List<String> smallAds = [
  "https://m.media-amazon.com/images/I/11M5KkkmavL._SS70_.png",
  "https://m.media-amazon.com/images/I/11iTpTDy6TL._SS70_.png",
  "https://m.media-amazon.com/images/I/11dGLeeNRcL._SS70_.png",
  "https://m.media-amazon.com/images/I/11kOjZtNhnL._SS70_.png",
];

const List<String> adItemNames = [
  "Amazon Pay",
  "Recharge",
  "Rewards",
  "Pay Bills"
];

// final myitems=[
//   Image.asset('lib/images/1.jpg',),
//   Image.asset('lib/images/2.jpg'),
//   Image.asset('lib/images/3.jpg'),
//   Image.asset('lib/images/4.jpg'),
// ];
int currpage = 0;

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
                items: widget.myitems,
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  pauseAutoPlayInFiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currpage = index;
                    });
                  },
                )),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedSmoothIndicator(
                    activeIndex: currpage,
                    count: widget.myitems.length,
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 10,
                      dotColor: Colors.white60,
                      activeDotColor: Colors.cyan,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          width: width,
          height: 120,
          color: Colors.blueGrey[50],
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getsmallads(0),
                getsmallads(1),
                getsmallads(2),
                getsmallads(3),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget getsmallads(int index) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
        width: 112,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 1)
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Image.network(smallAds[index]),
            ),
            Text(adItemNames[index]),
          ],
        )),
  );
}
