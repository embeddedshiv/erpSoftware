import 'package:flutter/material.dart';

class RegisterDialogButton extends StatelessWidget {
  final VoidCallback onPressed;
  const RegisterDialogButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const BorderRadius leafShape = BorderRadius.only(
      topLeft: Radius.circular(0),
      topRight: Radius.circular(30),
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF007BFF),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
        shape: const RoundedRectangleBorder(borderRadius: leafShape),
        textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        elevation: 0,
      ),
      child: const Text("Register"),
    );
  }
}
