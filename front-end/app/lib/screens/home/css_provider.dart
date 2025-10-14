import 'package:flutter/material.dart';

class CSSProvider extends InheritedWidget {
  final String bannerBgImage;
  final String clientsayBgImage;

  const CSSProvider({
    super.key,
    required this.bannerBgImage,
    required this.clientsayBgImage,
    required Widget child,
  }) : super(child: child);

  // Helper method to access provider
  static CSSProvider of(BuildContext context) {
    final CSSProvider? result =
        context.dependOnInheritedWidgetOfExactType<CSSProvider>();
    assert(result != null, 'No CSSProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CSSProvider oldWidget) {
    return bannerBgImage != oldWidget.bannerBgImage ||
        clientsayBgImage != oldWidget.clientsayBgImage;
  }
}

// Usage Example: Wrap your HomeScreen with CSSProvider in main.dart
// CSSProvider(
//   bannerBgImage: 'assets/banner/shapes.svg',
//   clientsayBgImage: 'assets/clientsay/bgimage.svg',
//   child: HomeScreen(),
// );
