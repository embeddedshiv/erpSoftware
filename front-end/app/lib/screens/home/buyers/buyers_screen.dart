import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/adaptive_layout.dart'; // ✅ import the updated helper file

class BuyersScreen extends StatelessWidget {
  const BuyersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> buyersData = [
      {
        'imgSrc': 'assets/images/buyers/ourbuyers.svg',
        'percent': '80k',
        'heading': 'Our buyers',
        'subheading': 'Follow a hashtag growth total posts, videos and images.',
      },
      {
        'imgSrc': 'assets/images/buyers/projectcompleted.svg',
        'percent': '90k',
        'heading': 'Project completed',
        'subheading': 'Follow a hashtag growth total posts, videos and images.',
      },
      {
        'imgSrc': 'assets/images/buyers/happybuyers.svg',
        'percent': '80%',
        'heading': 'Happy buyers',
        'subheading': 'Follow a hashtag growth total posts, videos and images.',
      },
      {
        'imgSrc': 'assets/images/buyers/teammembers.svg',
        'percent': '50+',
        'heading': 'Team members',
        'subheading': 'Follow a hashtag growth total posts, videos and images.',
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final double maxSpace = 5.0;

        final layout = calculateAdaptiveLayout(
          screenWidth,
          300, // maxContainerWidth
          buyersData.length,
          maxSpace, // maxSpace
          0.80, // shrinkLimit
          300,
        );

        debugPrint(
          "📏 [BUYERS LAYOUT] screenWidth=$screenWidth, "
          "itemWidth=${layout.itemWidth}, itemHeight=${layout.itemHeight}, "
          "spacing=${layout.spacing}, crossAxisCount=${layout.crossAxisCount}",
        );

        return Center(
          child: Container(
            color: Colors.white, // ✅ white background
            constraints: const BoxConstraints(maxWidth: 1600),
            padding: EdgeInsets.all(layout.spacing),
            child: Wrap(
              spacing: layout.spacing,
              runSpacing: layout.spacing,
              alignment: WrapAlignment.center,
              children: buyersData.map((buyer) {
                return Container(
                  width: layout.itemWidth,
                  height: layout.itemHeight,
                  padding: EdgeInsets.all(layout.spacing),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        buyer['imgSrc']!,
                        height: layout.itemHeight * 0.2,
                      ),
                      SizedBox(height: layout.itemHeight * 0.05),
                      Text(
                        buyer['percent']!,
                        style: TextStyle(
                          fontSize: layout.itemWidth * 0.08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        buyer['heading']!,
                        style: TextStyle(
                          fontSize: layout.itemWidth * 0.06,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: layout.itemHeight * 0.03),
                        child: Text(
                          buyer['subheading']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: layout.itemWidth * 0.045,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
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
