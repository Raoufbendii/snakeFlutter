import 'package:flutter/material.dart';

class BlankPixel extends StatelessWidget {
  const BlankPixel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 84, 82, 84),
              borderRadius: BorderRadius.circular(4)),
        ));
  }
}
