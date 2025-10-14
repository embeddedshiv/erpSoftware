import 'package:flutter/material.dart';
import 'banner/banner_screen.dart';
import 'navbar/drawer_screen.dart';
import 'navbar/navbar.dart';
import 'clientsay/clientsay_screen.dart';
import 'why/why_screen.dart';
import 'buyers/buyers_screen.dart';
import 'companies/companies_screen.dart';
import 'footer/footer_screen.dart';
import 'network/network_screen.dart';
import 'newsletter/newsletter_screen.dart';
import 'provide/provide_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: const [
                // Horizontal Navbar
                Navbar(),

                // Banner Section
                BannerScreen(),

                CompaniesScreen(),

                BuyersScreen(),   

                ProvideScreen(),

                // Why Choose Us Section
                WhyScreen(),            

                NetworkScreen(),

                // Clientsay Section
                ClientsayScreen(),

                // ✅ Newsletter + Footer (overlapping using Stack)
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: const [
                    // Footer is the base layer
                    FooterScreen(),

                    // Newsletter overlaps footer and ClientSay
                    Positioned(
                      top: -180, // adjust overlap height for visual alignment
                      left: 0,
                      right: 0,
                      child: NewsletterScreen(),
                    ),
                  ]
                ),
                // FooterScreen()
              ],
            ),
          ),

          // Custom Drawer Overlay for mobile
          CustomDrawer(
            isOpen: isDrawerOpen,
            onClose: () => setState(() => isDrawerOpen = false),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 10),
                Text('Home', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('About Us', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Services', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Contact', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
