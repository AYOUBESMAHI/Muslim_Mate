import 'dart:ui';

import 'package:flutter/material.dart';

import '../Screens/Pages/SearchCity_Page.dart';

class LocationWidget extends StatelessWidget {
  final String placeName;
  final Function changeCity;
  final Function changeCityGeo;
  final Color textColor;
  const LocationWidget(
      this.placeName, this.changeCity, this.changeCityGeo, this.textColor,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            height: 60,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(.35)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              textBaseline: TextBaseline.ideographic,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 200,
                  child: Text(
                    placeName,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 32,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => SearchCityPage(changeCity))),
                  child: Icon(
                    Icons.list,
                    color: textColor,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () => changeCityGeo(),
                  child: Icon(
                    Icons.my_location_outlined,
                    color: textColor,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
