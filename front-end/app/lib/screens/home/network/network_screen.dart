import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NetworkScreen extends StatelessWidget {
  const NetworkScreen({super.key});

  final List<Map<String, String>> aboutData = const [
    {
      'imgSrc': 'assets/images/network/bangladesh.svg',
      'country': 'Bangladesh',
      'paragraph': 'Event madness gathering innoies, & tech enthusiasts in Speced.',
    },
    {
      'imgSrc': 'assets/images/network/america.svg',
      'country': 'United States',
      'paragraph': 'Event madness gathering innoies, & tech enthusiasts in Speced.',
    },
    {
      'imgSrc': 'assets/images/network/australia.svg',
      'country': 'Australia',
      'paragraph': 'Event madness gathering innoies, & tech enthusiasts in Speced.',
    },
    {
      'imgSrc': 'assets/images/network/china.svg',
      'country': 'China',
      'paragraph': 'Event madness gathering innoies, & tech enthusiasts in Speced.',
    },
  ];

  Widget _buildImage(String path, double width, double height) {
    if (path.endsWith('.svg')) {
      return SvgPicture.asset(path, width: width, height: height);
    } else {
      return Image.asset(path, width: width, height: height);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFDBF2FF), // babyblue background
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Our network & world \nwork details.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 30),

          // Map Image
          _buildImage('assets/images/network/map.png', 1400, 800),
          const SizedBox(height: 30),

          // Network Cards
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: aboutData.map((item) {
              return Container(
                width: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildImage(item['imgSrc']!, 55, 55),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item['country']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF001F3D), // midnightblue
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                    Text(
                      item['paragraph']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF6B7280), // bluegrey
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
