import 'package:flutter/material.dart';
import 'register_dialog.dart';
import 'sign_dialog.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  final List<String> navigationItems = const [
    "Home",
    "Services",
    "About",
    "Project",
    "Help",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, // doubled height
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo on left
          Image.asset(
            'assets/images/logo/logo.png',
            height: 100,
          ),

          // Spacer between logo and nav text
          const SizedBox(width: 40),

          // Navigation links in center
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: navigationItems
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 30, // increased font size
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          // Buttons on right
          Row(
            children: [
              SignDialogButton(onPressed: () {}),
              const SizedBox(width: 16),
              RegisterDialogButton(onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
