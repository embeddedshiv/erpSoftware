import 'package:flutter/material.dart';
import 'drawer_data.dart';
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

class _NavbarState extends State<Navbar> {
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Stack(
      children: [
        // Horizontal navbar for wide screens
        if (!isMobile)
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo slightly moved right
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Image.asset(
                    'assets/images/logo/logo.png',
                    height: 100,
                  ),
                ),

                // Nav items
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: DrawerData.navigationItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: _NavItem(
                          label: item["name"]!,
                          onTap: () => widget.onItemSelected(item["name"]!),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Sign In / Register
                Row(
                  children: [
                    SignDialogButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true, // click outside to dismiss
                          builder: (_) => const LoginScreenPopup(),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    RegisterDialogButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true, // click outside to dismiss
                          builder: (_) => const RegisterScreenPopup(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

        // Mobile drawer icon
        if (isMobile)
          Positioned(
            left: 16,
            top: 40,
            child: IconButton(
              icon: const Icon(Icons.menu, size: 32),
              onPressed: () => setState(() => isDrawerOpen = true),
            ),
          ),

        // Drawer overlay
        if (isMobile && isDrawerOpen)
          GestureDetector(
            onTap: () => setState(() => isDrawerOpen = false),
            child: Container(
              color: Colors.black.withOpacity(0.25),
              width: double.infinity,
              height: double.infinity,
            ),
          ),

        // Drawer with vertical nav
        if (isMobile)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: isDrawerOpen ? 0 : -300,
            top: 0,
            bottom: 0,
            child: Container(
              width: 300,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: VerticalNavBar(
                onItemSelected: (label) {
                  widget.onItemSelected(label);
                  setState(() => isDrawerOpen = false);
                },
              ),
            ),
          ),
      ],
    );
  }
}

// Horizontal nav item
class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavItem({required this.label, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> with SingleTickerProviderStateMixin {
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
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
                    fontSize: 30,
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

// Vertical Navbar
class VerticalNavBar extends StatelessWidget {
  final Function(String) onItemSelected;
  const VerticalNavBar({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),

        // Logo at top
        Center(
          child: Image.asset(
            'assets/images/logo/logo.png',
            height: 70,
          ),
        ),
        const Divider(thickness: 1, height: 30),

        // Navigation items
        ...DrawerData.navigationItems.map(
          (item) => _VerticalNavItem(
            label: item["name"]!,
            onTap: () => onItemSelected(item["name"]!),
          ),
        ),

        const Spacer(),

        // Sign In / Register buttons at bottom
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignDialogButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true, // click outside to dismiss
                    builder: (_) => const LoginScreenPopup(),
                  );
                },
              ),
              const SizedBox(width: 16),
              RegisterDialogButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true, // click outside to dismiss
                    builder: (_) => const RegisterScreenPopup(),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class _VerticalNavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _VerticalNavItem({required this.label, required this.onTap});

  @override
  State<_VerticalNavItem> createState() => _VerticalNavItemState();
}

class _VerticalNavItemState extends State<_VerticalNavItem>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
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
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 18,
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
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
