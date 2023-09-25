import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AyahCard extends StatelessWidget {
  final String ayahArabic;
  final String ayahEnglish;
  final String ayahTransliteration;

  const AyahCard(this.ayahArabic, this.ayahEnglish, this.ayahTransliteration,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              textScaleFactor: 1.3,
              textAlign: TextAlign.justify,
              ayahArabic,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontFamily: "hafs",
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            color: HexColor("#011840"),
          ),
          Text(
            ayahTransliteration,
            style: TextStyle(
                fontSize: 18,
                color: HexColor("#011840"),
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.justify,
          ),
          Divider(
            color: HexColor("#011840"),
          ),
          Text(
            ayahEnglish,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
