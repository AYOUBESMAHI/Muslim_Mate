import 'dart:ui';

import 'package:flutter/material.dart';
//Services
import '../Services/SavingData_Service.dart';
//Utils
import '../Utils/Helpers.dart';

class SinglePrayTimeTile extends StatefulWidget {
  final String prayerName;
  final String preyerTime;
  final Duration endPrayer;
  final bool isCurrentPray;
  final bool isTimerCurrentPray;
  final Color textColor;

  const SinglePrayTimeTile(this.prayerName, this.preyerTime, this.isCurrentPray,
      this.isTimerCurrentPray, this.endPrayer, this.textColor,
      {super.key});

  @override
  State<SinglePrayTimeTile> createState() => _SinglePrayTimeTileState();
}

class _SinglePrayTimeTileState extends State<SinglePrayTimeTile> {
  bool isOn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    isOn = await getPrayerNotification(widget.prayerName);
  }

  @override
  Widget build(BuildContext context) {
    final hours = twoDegits(widget.endPrayer.inHours);
    final minutes = twoDegits(widget.endPrayer.inMinutes.remainder(60));
    final seconds = twoDegits(widget.endPrayer.inSeconds.remainder(60));

    return ClipRRect(
      borderRadius: BorderRadius.circular(1),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          height: 46,
          width: 520,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            color: !widget.isCurrentPray
                ? const Color.fromARGB(255, 255, 255, 255).withOpacity(.35)
                : Color.fromARGB(176, 255, 255, 255),
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    widget.prayerName,
                    style: TextStyle(
                        color: widget.textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
              Expanded(
                flex: 3,
                child: widget.isTimerCurrentPray
                    ? RichText(
                        text: TextSpan(
                            text: "Start In ",
                            style: TextStyle(
                                color: widget.textColor,
                                fontWeight: FontWeight.bold),
                            children: [
                            TextSpan(
                              text: " $hours : $minutes : $seconds",
                              style: TextStyle(
                                  color: widget.textColor,
                                  fontWeight: FontWeight.w500),
                            )
                          ]))
                    : Container(),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  widget.preyerTime,
                  style: TextStyle(
                      color: widget.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  updatePrayerNotification(widget.prayerName, !isOn);
                  isOn = !isOn;
                  print(isOn);
                  setState(() {});
                },
                child: Icon(
                  !isOn ? Icons.notification_add : Icons.notifications_rounded,
                  color: isOn
                      ? const Color.fromARGB(208, 255, 255, 0)
                      : widget.textColor,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
