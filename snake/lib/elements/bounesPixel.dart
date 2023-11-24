import 'package:flutter/material.dart';

class BounesPixel extends StatelessWidget {
  const BounesPixel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 220, 224, 9),
              borderRadius: BorderRadius.circular(4)),
        ));
  }
}
