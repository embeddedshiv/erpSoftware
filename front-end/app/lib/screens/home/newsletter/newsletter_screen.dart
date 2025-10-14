import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewsletterScreen extends StatelessWidget {
  const NewsletterScreen({super.key});

  Widget _buildImage(String path, {double? width, double? height}) {
    if (path.endsWith('.svg')) {
      return SvgPicture.asset(path, width: width, height: height);
    } else {
      return Image.asset(path, width: width, height: height, fit: BoxFit.contain);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        width: 900,
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6), // blue-500
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Left Images (desktop-like layout)
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                width: 380,
                child: Stack(
                  children: [
                    _buildImage(
                      'assets/images/newsletter/bgImage.png',
                      width: 360,
                      height: 220,
                    ),
                    Positioned(
                      top: 10,
                      right: 0,
                      child: _buildImage(
                        'assets/images/newsletter/leaf.svg',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 10,
                      child: _buildImage(
                        'assets/images/newsletter/circel.svg',
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Text and Input
            Padding(
              padding: const EdgeInsets.fromLTRB(400, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sign up to our newsletter.",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Craven omni memoria patriae zombieland clairvius narcisse religionis sunt diri undead historiarum.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFEBF4FF),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '@enter email-address',
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            fillColor: Colors.white,
                            filled: true,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2563EB),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: _buildImage(
                            'assets/images/newsletter/plane.svg',
                            width: 22,
                            height: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
