import 'package:flutter/material.dart';

class FoodPixel extends StatelessWidget {
  const FoodPixel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 10, 199, 38),
              borderRadius: BorderRadius.circular(4)),
        ));
  }
}
