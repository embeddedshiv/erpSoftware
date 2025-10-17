import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../css_provider.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const BorderRadius leafShape = BorderRadius.only(
      topLeft: Radius.circular(0.0),
      topRight: Radius.circular(30.0),
      bottomLeft: Radius.circular(30.0),
      bottomRight: Radius.circular(30.0),
    );

    final bannerBg = CSSProvider.of(context).bannerBgImage;

    // Width and height of navbar
    const double navbarWidth = 80.0;
    const double navbarHeight = 80.0;

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          // Background shapes
          Positioned.fill(
            child: SvgPicture.asset(bannerBg, fit: BoxFit.contain),
          ),
          // Banner content
          Padding(
            padding: const EdgeInsets.only(
              left: navbarWidth,
              top: navbarHeight + 40, // push content below navbar
              right: 24,
              bottom: 40,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text Section
                  const Text(
                    "Solve problem with an\nintegrated agency.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF001F3D),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Ehya is the Instagram analytics platform teams use to stay focused "
                    "on the goals, track engagement for report your business.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF6B7280),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF007BFF),
                          shape: const RoundedRectangleBorder(
                            borderRadius: leafShape,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 45,
                            vertical: 30,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          debugPrint("See our portfolio button clicked");
                        },
                        child: const Text('See our portfolio'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFF007BFF),
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: leafShape,
                          ),
                          side: const BorderSide(color: Color(0xFFD1D5DB)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 45,
                            vertical: 30,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          debugPrint("More info button clicked");
                        },
                        child: const Text('More info'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Dashboard image bigger
                  SvgPicture.asset(
                    'assets/images/banner/dashboard.svg',
                    width: 1400,
                    height: 700,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
