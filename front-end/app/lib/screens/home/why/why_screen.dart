import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/adaptive_layout.dart';

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

    return LayoutBuilder(
      builder: (context, constraints) {
        // -----------------------------
        // MAIN CONTAINER LAYOUT
        // -----------------------------
        final mainLayout = calculateAdaptiveLayout(
          screenWidth,
          650,
          2, // 2 columns: image + text
          40, // spacing between columns
          0.8, // shrink limit
          600, // max height per container
        );

        final container1Width = mainLayout.itemWidth; // iPad image
        final container2Width = mainLayout.itemWidth; // text + checks

        debugPrint(
          "📏 [MAIN LAYOUT] screenWidth=$screenWidth, itemWidth=${mainLayout.itemWidth}, itemHeight=${mainLayout.itemHeight}, spacing=${mainLayout.spacing}, crossAxisCount=${mainLayout.crossAxisCount}",
        );

        return SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(mainLayout.spacing),
              constraints: const BoxConstraints(maxWidth: 1600),
              color: Colors.white,
              child: Wrap(
                spacing: mainLayout.spacing,
                runSpacing: mainLayout.spacing,
                alignment: WrapAlignment.center,
                children: [
                  // -----------------------------
                  // CONTAINER 1: iPad Image
                  // -----------------------------
                  Container(
                    width: container1Width,
                    height: mainLayout.itemHeight,
                    child: Image.asset(
                      'assets/images/why/iPad.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  // -----------------------------
                  // CONTAINER 2: Text + Checks
                  // -----------------------------
                  Container(
                    width: container2Width,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Why we best?',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF001F3D),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Don\'t waste time on manual tasks. Let Automation do it for you. Simplify workflows, reduce errors, and save time.',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Column(
                          children: whyData.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Check icon
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFE5E7EB),
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
              ),
            ),
          ),
        );
      },
    );
  }
}
