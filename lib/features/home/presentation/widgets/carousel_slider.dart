import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:salla/features/home/data/models/home_model.dart';

class CarouselSliderBuilder extends StatelessWidget {
  final HomeModel? homeDate;

  const CarouselSliderBuilder({Key? key, required this.homeDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: homeDate!.data.banners
          .map((e) => CachedNetworkImage(
                imageUrl: e.image,
              ))
          .toList(),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
        height: 250,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        initialPage: 0,
        pauseAutoPlayOnTouch: true,
      ),
    );
  }
}
