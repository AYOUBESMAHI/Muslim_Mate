import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:muslim_mate/Models/Surah.dart';

class SurahTitleCard extends StatelessWidget {
  final Surah surah;
  const SurahTitleCard(this.surah, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      decoration: BoxDecoration(
        color: HexColor("#011840"),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${surah.title}  ${surah.titleAr}',
                style: const TextStyle(
                  color: Colors.white,
                  //fontFamily: 'BebasNeue',
                  //fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 19),
              Text(
                surah.englishNameTranslation,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                surah.type,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 9),
              Text(
                "${surah.count} Verses",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Surah",
              style: TextStyle(
                color: HexColor('#C1BF88'),
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 11),
            Text(
              surah.index.toString(),
              style: TextStyle(
                color: HexColor('#C1BF88'),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 11),
            ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(HexColor("#F7F1EA")),
                    foregroundColor:
                        MaterialStatePropertyAll(HexColor("#011840")),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)))),
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
                label: const Text(
                  'Play Surah',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
          ],
        )
      ]),
    );
  }
}
