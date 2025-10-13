import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Text Section
              Center(
                child: Column(
                  children: const [
                    Text(
                      "Nyasa Technologies \nEmpower Your Dreams",
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007BFF),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 36),
                    ),
                    child: const Text(
                      "See our portfolio",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD1D5DB)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 36),
                    ),
                    child: const Text(
                      "More info",
                      style: TextStyle(fontSize: 15, color: Color(0xFF007BFF)),
                    ),
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
      ),
    );
  }
}
