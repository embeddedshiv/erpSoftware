import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({super.key});

  final List<Map<String, String>> data = const [
    {'imgSrc': 'assets/images/carousel/google.svg'},
    {'imgSrc': 'assets/images/carousel/garnier.png'},
    {'imgSrc': 'assets/images/carousel/slack.png'},
    {'imgSrc': 'assets/images/carousel/udemy.png'},
    {'imgSrc': 'assets/images/carousel/google.svg'},
    {'imgSrc': 'assets/images/carousel/garnier.png'},
    {'imgSrc': 'assets/images/carousel/slack.png'},
    {'imgSrc': 'assets/images/carousel/udemy.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine number of visible items based on screen width
    int slidesToShow = 4;
    if (screenWidth <= 500) {
      slidesToShow = 1;
    } else if (screenWidth <= 700) {
      slidesToShow = 2;
    } else if (screenWidth <= 1024) {
      slidesToShow = 4;
    }

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: data.length,
            itemBuilder: (context, index, realIndex) {
              final item = data[index];
              final isSvg = item['imgSrc']!.endsWith('.svg');
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  alignment: Alignment.center,
                  child: isSvg
                      ? SvgPicture.asset(
                          item['imgSrc']!,
                          width: 150,
                          height: 150,
                        )
                      : Image.asset(
                          item['imgSrc']!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                ),
              );
            },
            options: CarouselOptions(
              viewportFraction: 1 / slidesToShow,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              enableInfiniteScroll: true,
              scrollPhysics: const BouncingScrollPhysics(),
              enlargeCenterPage: false,
              disableCenter: true,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(thickness: 1, color: Colors.grey),
        ],
      ),
    );
  }
}
