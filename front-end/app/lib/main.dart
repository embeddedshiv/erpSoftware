import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/css_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Screen Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: CSSProvider(
        bannerBgImage: 'assets/images/banner/shapes.svg',
        clientsayBgImage: 'assets/images/clientsay/bgimage.svg',
        child: const HomeScreen(),
      ),
    );
  }
}
