import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyersScreen extends StatelessWidget {
  const BuyersScreen({super.key});

  final List<Map<String, String>> cardData = const [
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 1024
        ? 4
        : screenWidth > 640
            ? 2
            : 1;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cardData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 20,
          mainAxisSpacing: 40,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final item = cardData[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD1D5DB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(
                  item['imgSrc']!,
                  width: 30,
                  height: 30,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                item['percent']!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item['heading']!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item['subheading']!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
