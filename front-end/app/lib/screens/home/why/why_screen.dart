import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WhyScreen extends StatelessWidget {
  const WhyScreen({super.key});

  final List<Map<String, String>> whyData = const [
    {
      'heading': 'Quality',
      'subheading':
          'Follow a hashtag growth total posts, videos and images. More revisions.',
    },
    {
      'heading': 'Communication',
      'subheading':
          'Follow a hashtag growth total posts, videos and images. More revisions.',
    },
    {
      'heading': 'Reliability',
      'subheading':
          'Follow a hashtag growth total posts, videos and images. More revisions.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth >= 1024;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: iPad Image (SVG)
              if (isLargeScreen)
                Expanded(
                  child: Image.asset(
                    'assets/images/why/iPad.png',
                    fit: BoxFit.contain,
                  ),
                ),

              const SizedBox(width: 40),

              // Right Column: Text + Check items
              Expanded(
                child: Column(
                  crossAxisAlignment: isLargeScreen
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Why we best?',
                      style: TextStyle(
                        fontSize: isLargeScreen ? 48 : 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF001F3D),
                      ),
                      textAlign:
                          isLargeScreen ? TextAlign.left : TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Don\'t waste time on manual tasks. Let Automation do it for you. Simplify workflows, reduce errors, and save time.',
                      style: TextStyle(
                        fontSize: isLargeScreen ? 18 : 16,
                        color: const Color(0xFF6B7280),
                      ),
                      textAlign:
                          isLargeScreen ? TextAlign.left : TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // Check items
                    Column(
                      children: whyData.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Check icon (SVG)
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE5E7EB),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/images/why/check.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['heading']!,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF001F3D),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['subheading']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
