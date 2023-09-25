import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:muslim_mate/Screens/Pages/Quran_Page.dart';

class SurahListTile extends StatelessWidget {
  final int index;
  final String title;
  final int verses;
  final String titleAr;
  const SurahListTile(this.index, this.title, this.verses, this.titleAr,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => QuranPage(index - 1, -1))),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    iconSize: 32,
                    onPressed: () {},
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      color: HexColor('#011840'),
                    )),
                Column(
                  children: [
                    Text(
                      "$index. $title",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$verses Verses',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Text(
              titleAr,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: "hafs",
                color: HexColor('#011840'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
