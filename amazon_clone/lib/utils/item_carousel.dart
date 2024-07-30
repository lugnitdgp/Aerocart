import 'package:amazon_clone/utils/carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemCarousel extends StatefulWidget {
  final List<Widget> myitems;
  const ItemCarousel({super.key, required this.myitems});

  @override
  State<ItemCarousel> createState() => _ItemCarouselState();
}

class _ItemCarouselState extends State<ItemCarousel> {
  int currpage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        children: [
          CarouselSlider(
              items: myitems,
              options: CarouselOptions(
                autoPlay: false,
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
                  count: myitems.length,
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
    ]);
  }
}
