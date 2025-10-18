import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/adaptive_layout.dart'; // make sure your adaptive_layout.dart is in utils

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
    {'imgSrc': 'assets/images/carousel/google.png'},
    {'imgSrc': 'assets/images/carousel/garnier.png'},
    {'imgSrc': 'assets/images/carousel/slack.png'},
    {'imgSrc': 'assets/images/carousel/udemy.png'},
    {'imgSrc': 'assets/images/carousel/google.png'},
    {'imgSrc': 'assets/images/carousel/garnier.png'},
    {'imgSrc': 'assets/images/carousel/slack.png'},
    {'imgSrc': 'assets/images/carousel/udemy.png'},
  ];

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..addListener(() {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(
                _animationController.value *
                    _scrollController.position.maxScrollExtent,
              );
            }
          });

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        // -----------------------------
        // Adaptive layout for logos
        // -----------------------------
        final logoLayout = calculateAdaptiveLayout(
          screenWidth,
          120, // max logo width
          data.length, // default 4 logos per row
          40, // spacing between logos
          0.8, // shrink limit
          120, // max logo height
        );

        debugPrint(
          "📏 [LOGO LAYOUT] screenWidth=$screenWidth | itemWidth=${logoLayout.itemWidth}, itemHeight=${logoLayout.itemHeight}, spacing=${logoLayout.spacing}, crossAxisCount=${logoLayout.crossAxisCount}",
        );

        return Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: logoLayout.spacing,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              children: data.map((item) {
                final isSvg = item['imgSrc']!.endsWith('.svg');

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: logoLayout.spacing),
                  child: SizedBox(
                    width: logoLayout.itemWidth,
                    height: logoLayout.itemHeight,
                    child: Builder(
                      builder: (_) {
                        try {
                          if (isSvg) {
                            return SvgPicture.asset(
                              item['imgSrc']!,
                              width: logoLayout.itemWidth,
                              height: logoLayout.itemHeight,
                              fit: BoxFit.contain,
                            );
                          } else {
                            return Image.asset(
                              item['imgSrc']!,
                              width: logoLayout.itemWidth,
                              height: logoLayout.itemHeight,
                              fit: BoxFit.contain,
                            );
                          }
                        } catch (e) {
                          debugPrint(
                            "⚠️ Failed to load logo: ${item['imgSrc']} | Error: $e",
                          );
                          return Container(
                            width: logoLayout.itemWidth,
                            height: logoLayout.itemHeight,
                            color: Colors.grey[300],
                            child: const Center(child: Icon(Icons.error)),
                          );
                        }
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
