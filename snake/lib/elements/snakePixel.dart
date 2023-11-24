import 'package:flutter/material.dart';

class SnakePixel extends StatelessWidget {
  const SnakePixel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 207, 8, 8),
              borderRadius: BorderRadius.circular(4)),
        ));
  }
}
