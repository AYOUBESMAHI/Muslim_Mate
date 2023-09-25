import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Screens/Pages/Quran_Page.dart';

class JuzListTile extends StatelessWidget {
  final int id;
  final List<Map<String, dynamic>> swarIn;
  const JuzListTile(this.id, this.swarIn, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => QuranPage(
              swarIn[0]["index"] - 1, int.parse(swarIn[0]["ayahStart"]) - 1))),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Juz $id',
            style: const TextStyle(
                fontSize: 19, fontWeight: FontWeight.w700, color: Colors.brown),
          ),
          const SizedBox(height: 6),
          ...List.generate(
            swarIn.length,
            (index) => Container(
              margin: const EdgeInsets.only(bottom: 3),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' ${swarIn[index]["index"]}.${swarIn[index]["Title"]} ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: HexColor('#011840')),
                  ),
                  Text(
                    'Verses ${swarIn[index]["ayahStart"]} - ${swarIn[index]["ayahEnd"]}',
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
