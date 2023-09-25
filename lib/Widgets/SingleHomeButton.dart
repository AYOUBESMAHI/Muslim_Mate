import 'dart:ui';

import 'package:flutter/material.dart';

class SingleHomeButton extends StatelessWidget {
  final String label;
  final String icon;
  const SingleHomeButton(this.label, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8,
                sigmaY: 8,
              ),
              child: Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color:
                      const Color.fromARGB(255, 114, 180, 234).withOpacity(.35),
                ),
                child: Image.asset(icon),
              ))),
      const SizedBox(height: 6),
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      )
    ]);
  }
}
