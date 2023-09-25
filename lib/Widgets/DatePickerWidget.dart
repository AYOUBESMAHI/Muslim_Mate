import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatelessWidget {
  final DateTime date;
  final Function setPrayerTime;
  final Color textColor;
  const DatePickerWidget(this.date, this.setPrayerTime, this.textColor,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(1),
        child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              height: 100,
              width: 520,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                color: Colors.white.withOpacity(.3),
              ),
              child: SizedBox(
                height: 90,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setPrayerTime(date.subtract(const Duration(days: 1)));
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: textColor,
                          size: 30,
                        )),
                    Expanded(
                        child: ListTile(
                      title: Text(
                        HijriCalendar.fromDate(date).fullDate(),
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(DateFormat('MMMM d, y').format(date),
                          style: TextStyle(
                              color: textColor, fontWeight: FontWeight.bold)),
                    )),
                    IconButton(
                        onPressed: () {
                          setPrayerTime(DateTime.now());
                        },
                        icon: Icon(
                          Icons.today,
                          color: textColor,
                          size: 30,
                        )),
                    IconButton(
                        onPressed: () {
                          setPrayerTime(date.add(const Duration(days: 1)));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: textColor,
                          size: 30,
                        )),
                  ],
                ),
              ),
            )));
  }
}
