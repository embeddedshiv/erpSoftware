import 'package:flutter/material.dart';
import 'navbar/navbar.dart';
import './banner/banner_screen.dart';
import './provide/provide_screen.dart';
import './why/why_screen.dart';
import './network/network_screen.dart';
import './footer/footer_screen.dart';
import './buyers/buyers_screen.dart'; // <-- Import BuyersScreen
import './companies/companies_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  // Keys for sections to scroll to
  final GlobalKey _bannerKey = GlobalKey();
  final GlobalKey _companiesKey = GlobalKey();
  final GlobalKey _buyersKey = GlobalKey(); // <-- Key for BuyersScreen
  final GlobalKey _provideKey = GlobalKey();
  final GlobalKey _whyKey = GlobalKey();
  final GlobalKey _networksKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();

  // Scroll to the specific section based on nav item
  void _scrollToSection(String name) {
    final map = {
      "Home": _bannerKey,
      "Companies": _companiesKey,
      "Buyers": _buyersKey, // <-- Add Buyers section to map
      "Services": _provideKey,
      "About": _whyKey,
      "Project": _networksKey,
      "Help": _footerKey,
    };
    final key = map[name];
    if (key == null) return;

    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 800;

        return Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    _buildSection(_bannerKey, const BannerScreen()),
                    _buildSection(_companiesKey, const CompaniesScreen()),
                    _buildSection(_buyersKey, BuyersScreen()),
                    _buildSection(_provideKey, const ProvideScreen()),
                    _buildSection(_whyKey, const WhyScreen()),
                    _buildSection(_networksKey, const NetworkScreen()),
                    _buildSection(_footerKey, const FooterScreen()),
                  ],
                ),
              ),
              // Navbar (horizontal or drawer toggle) dynamically
              Navbar(onItemSelected: _scrollToSection),
            ],
          ),
          // Drawer only for mobile
          drawer: isMobile
              ? Drawer(child: VerticalNavBar(onItemSelected: _scrollToSection))
              : null,
        );
      },
    );
  }

  // Wrap each section in a key
  Widget _buildSection(GlobalKey key, Widget section) {
    return Container(key: key, width: double.infinity, child: section);
  }
}
