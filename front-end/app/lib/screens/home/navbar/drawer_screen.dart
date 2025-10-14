import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final Widget child;

  const CustomDrawer({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return isOpen
        ? Stack(
            children: [
              GestureDetector(
                onTap: onClose,
                child: Container(
                  color: Colors.black.withOpacity(0.25),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 300,
                  height: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: child,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
