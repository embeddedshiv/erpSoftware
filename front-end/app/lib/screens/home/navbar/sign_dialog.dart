import 'package:flutter/material.dart';

class SignDialogButton extends StatefulWidget {
  final VoidCallback onPressed;
  const SignDialogButton({super.key, required this.onPressed});

  @override
  State<SignDialogButton> createState() => _SignDialogButtonState();
}

class _SignDialogButtonState extends State<SignDialogButton>
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
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: Text(
              "Sign In",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: _hovered ? const Color(0xFF007BFF) : Colors.black87,
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
