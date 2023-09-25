import 'package:flutter/material.dart';

class SingleGridSection extends StatelessWidget {
  final String icon;
  final String name;
  final int length;
  const SingleGridSection(this.icon, this.name, this.length, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        Expanded(
          child: Image.asset(
            icon,
          ),
        ),
        FittedBox(
          child: Text(
            name,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
        Text(
          '$length دكر',
          textDirection: TextDirection.rtl,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ]),
    );
  }
}
