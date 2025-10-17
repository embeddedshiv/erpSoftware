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

  static CSSProvider of(BuildContext context) {
    final CSSProvider? result = context
        .dependOnInheritedWidgetOfExactType<CSSProvider>();
    assert(result != null, 'No CSSProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CSSProvider oldWidget) {
    return bannerBgImage != oldWidget.bannerBgImage ||
        clientsayBgImage != oldWidget.clientsayBgImage;
  }
}
