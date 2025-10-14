import 'package:flutter/material.dart';
import '../css_provider.dart';

class ClientsayScreen extends StatelessWidget {
  const ClientsayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final css = CSSProvider.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(css.clientsayBgImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Heading
              Text(
                "What say clients about us.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF001F3D),
                ),
              ),
              const SizedBox(height: 16),

              // Subheading
              Text(
                "Event madness gathering innoies, & tech enthusiasts in Speced. "
                "Do more informations.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF4B5563),
                ),
              ),
              const SizedBox(height: 40),

              // Avatar + Card
              Stack(
                alignment: Alignment.center,
                children: [
                  // Large background image (shown only for large screens)
                  Image.asset(
                    'assets/images/clientsay/avatars.png',
                    width: 1061,
                    height: 733,
                    fit: BoxFit.contain,
                  ),

                  // Positioned user card
                  Positioned(
                    bottom: 45,
                    left: 60,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/clientsay/user.png',
                          width: 168,
                          height: 168,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: const [
                              Text(
                                "Build your financial literacy within a transparent "
                                "community. Follow other investors, share people from "
                                "different professional backgrounds, and never be alone.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF4B5563),
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Jony Scotty",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "UI Designer",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
