import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _animationController;

  final List<Map<String, String>> data = const [
    {'imgSrc': 'assets/images/carousel/google.svg'},
    {'imgSrc': 'assets/images/carousel/garnier.png'},
    {'imgSrc': 'assets/images/carousel/slack.png'},
    {'imgSrc': 'assets/images/carousel/udemy.png'},
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
  void initState() {
    super.initState();

    // Animation controller for continuous smooth scroll
    _animationController =
        AnimationController(
          vsync: this,
          duration: const Duration(seconds: 25), // total scroll cycle time
        )..addListener(() {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(
              _animationController.value *
                  _scrollController.position.maxScrollExtent,
            );
          }
        });

    // repeat forever for infinite scroll
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 160, // 👈 height just enough for logos
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length * 2, // 👈 duplicate list for looping illusion
        itemBuilder: (context, index) {
          final item = data[index % data.length];
          final isSvg = item['imgSrc']!.endsWith('.svg');
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40), // equal space
            child: SizedBox(
              width: 100,
              height: 100,
              child: isSvg
                  ? SvgPicture.asset(
                      item['imgSrc']!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      item['imgSrc']!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
            ),
          );
        },
      ),
    );
  }
}
