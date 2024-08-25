import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemCarousel extends StatefulWidget {
  final List<Widget> myitemss;
  const ItemCarousel({super.key, required this.myitemss});

  @override
  State<ItemCarousel> createState() => _ItemCarouselState();
}

class _ItemCarouselState extends State<ItemCarousel> {
  int currpage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
          items: widget.myitemss,
          options: CarouselOptions(
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 2),
            pauseAutoPlayInFiniteScroll: false,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currpage = index;
              });
            },
          )),
          const SizedBox(height: 10,),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,0),
          child: AnimatedSmoothIndicator(
            activeIndex: currpage,
            count: widget.myitemss.length,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              spacing: 10,
              dotColor: Colors.black,
              activeDotColor: Colors.cyan,
            ),
          ),
        ),
      ),
    ]);
  }
}
