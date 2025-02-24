import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.teal,
      shape: const CircleBorder(),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.smart_toy_outlined,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(height: 2),
            Text(
              "Ask AI",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}