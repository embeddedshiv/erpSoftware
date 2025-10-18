import 'package:flutter/material.dart';
import './drawer_data.dart';
import './sign_dialog.dart';
import './register_dialog.dart';
import '../../auth/login_screen.dart';
import '../../auth/register_screen.dart';

class Navbar extends StatefulWidget {
  final Function(String) onItemSelected;
  const Navbar({super.key, required this.onItemSelected});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> with SingleTickerProviderStateMixin {
  bool isDrawerOpen = false;
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  void openDrawer() {
    setState(() => isDrawerOpen = true);
    _controller.forward();
  }

  void closeDrawer() async {
    await _controller.reverse();
    setState(() => isDrawerOpen = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final bool useCompactLayout = screenWidth < 950;

        return Stack(
          children: [
            Container(
              height: 100,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ----------------------------
                  // LOGO
                  // ----------------------------
                  Image.asset('assets/images/logo/logo.png', height: 80),

                  // ----------------------------
                  // NAVBAR ITEMS (HORIZONTAL)
                  // ----------------------------
                  if (!useCompactLayout)
                    Expanded(
                      child: Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 40,
                          children: DrawerData.navigationItems.map((item) {
                            return _AnimatedNavItem(
                              label: item["name"]!,
                              onTap: () => widget.onItemSelected(item["name"]!),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                  // ----------------------------
                  // SIGN-IN / REGISTER / MENU ICON
                  // ----------------------------
                  Row(
                    children: [
                      if (!useCompactLayout) ...[
                        SignDialogButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (_) => LoginScreenPopup(),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        RegisterDialogButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (_) => RegisterScreenPopup(),
                            );
                          },
                        ),
                      ],
                      if (useCompactLayout)
                        IconButton(
                          icon: const Icon(Icons.menu, size: 32),
                          onPressed: openDrawer,
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // ----------------------------
            // DRAWER BACKDROP
            // ----------------------------
            if (isDrawerOpen)
              GestureDetector(
                onTap: closeDrawer,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),

            // ----------------------------
            // DRAWER PANEL
            // ----------------------------
            if (isDrawerOpen)
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 300,
                      height: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(Icons.close, size: 28),
                              onPressed: closeDrawer,
                            ),
                          ),
                          Center(
                            child: Image.asset(
                              'assets/images/logo/logo.png',
                              height: 70,
                            ),
                          ),
                          const Divider(thickness: 1, height: 30),

                          // ----------------------------
                          // DRAWER NAV ITEMS
                          // ----------------------------
                          ...DrawerData.navigationItems.map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: _AnimatedNavItem(
                                label: item["name"]!,
                                onTap: () {
                                  widget.onItemSelected(item["name"]!);
                                  closeDrawer();
                                },
                              ),
                            ),
                          ),

                          const Spacer(),

                          // ----------------------------
                          // SIGN-IN + REGISTER (BOTTOM ROW)
                          // ----------------------------
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SignDialogButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (_) => LoginScreenPopup(),
                                  );
                                },
                              ),
                              const SizedBox(width: 16),
                              RegisterDialogButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (_) => RegisterScreenPopup(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ------------------------------------------------------------
// HOVER ANIMATION NAVBAR ITEM
// ------------------------------------------------------------
class _AnimatedNavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _AnimatedNavItem({required this.label, required this.onTap});

  @override
  State<_AnimatedNavItem> createState() => _AnimatedNavItemState();
}

class _AnimatedNavItemState extends State<_AnimatedNavItem>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _controller.forward();
        setState(() => _hovered = true);
      },
      onExit: (_) {
        _controller.reverse();
        setState(() => _hovered = false);
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: _hovered ? const Color(0xFF007BFF) : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 2,
                  width: _hovered ? 30 : 0,
                  color: const Color(0xFF007BFF),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
