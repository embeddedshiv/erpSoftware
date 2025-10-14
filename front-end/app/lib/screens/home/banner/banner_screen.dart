import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Text Section
            const Center(
              child: Column(
                children: [
                  Text(
                    "Solve problem with an\nintegrated agency.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF001F3D),
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Ehya is the Instagram analytics platform teams use to stay focused "
                    "on the goals, track engagement for report your business.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF6B7280),
                      height: 1.5,
                    ),
                  ),
                ],
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
                        horizontal: 45, vertical: 30),
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
                        horizontal: 45, vertical: 30),
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

            // Banner Image
            SvgPicture.asset(
              'assets/images/banner/dashboard.svg',
              width: 1200,
              height: 598,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
