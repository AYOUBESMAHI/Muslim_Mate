import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../Models/Supplication.dart';

class SingleSupplication extends StatelessWidget {
  final Supplication supplication;
  const SingleSupplication(this.supplication, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 43, horizontal: 12),
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
      child: Column(
        children: [
          if (supplication.bodyVocalized.length < 500)
            const Spacer(
              flex: 2,
            ),
          Expanded(
            flex: 4,
            child: ListView(
              children: [
                Text(
                  supplication.bodyVocalized,
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Text(
                  supplication.note,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Divider(
                      color: HexColor('#011840'),
                      thickness: 2,
                    ),
                    Text(
                      "${supplication.counter} / ${supplication.repeat}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: CircularPercentIndicator(
                  key: UniqueKey(),
                  radius: 60.0,
                  lineWidth: 10.0,
                  percent: supplication.counterPercentage,
                  animation: false,
                  animationDuration: 1200,
                  center: Text(
                    "${supplication.counter}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  backgroundColor: Colors.grey,
                  progressColor: HexColor('#011840'),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Divider(
                      color: HexColor('#011840'),
                      thickness: 2,
                    ),
                    Text(
                      supplication.repeat == 1
                          ? "مرة واحدة"
                          : '${supplication.repeat} مرات ',
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
