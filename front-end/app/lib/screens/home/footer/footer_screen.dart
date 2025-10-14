import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FooterScreen extends StatelessWidget {
  const FooterScreen({super.key});

  final List<List<String>> products = const [
    ["Home", "Popular", "About", "Contact"],
    ["Help", "Resources", "Application", "Team"],
  ];

  Widget _buildSocialIcon(String assetPath, double width, double height) {
    if (assetPath.endsWith('.svg')) {
      return SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
      );
    } else {
      return Image.asset(
        assetPath,
        width: width,
        height: height,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF001F3D), // Dark Blue Background
      padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Footer Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column 1 - Logo & Social
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/footer/logo.svg',
                    height: 48,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      _buildSocialIcon('assets/images/footer/facebook.svg', 50, 50),
                      const SizedBox(width: 30),
                      _buildSocialIcon('assets/images/footer/twitter.svg', 50, 50),
                      const SizedBox(width: 30),
                      _buildSocialIcon('assets/images/footer/instagram.svg', 50, 50),
                    ],
                  ),
                ],
              ),

              // Column 2 & 3 - Links
              for (var linkList in products)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var link in linkList)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            link,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

              // Column 4 - Contact Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildSocialIcon('assets/images/footer/mask.svg', 24, 24),
                      const SizedBox(width: 8),
                      const Text(
                        '925 Filbert Street Pennsylvania 18072',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildSocialIcon('assets/images/footer/telephone.svg', 24, 24),
                      const SizedBox(width: 8),
                      const Text(
                        '+ 45 34 11 44 11',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildSocialIcon('assets/images/footer/email.svg', 24, 24),
                      const SizedBox(width: 8),
                      const Text(
                        'info@gmail.com',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 32),
          const Divider(color: Colors.white54),

          // Bottom Section - Rights & Policies
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 8,
              children: [
                const Text(
                  '@2025 Agency. All Rights Reserved. Distributed by ThemeWagon.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Privacy policy',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    SizedBox(width: 8),
                    VerticalDivider(color: Colors.white70, thickness: 1),
                    SizedBox(width: 8),
                    Text(
                      'Terms & conditions',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
