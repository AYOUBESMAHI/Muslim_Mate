import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Services/GeoLocation_Service.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Position? currentPos;
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    currentPos = await determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    Coordinates coordinates = Coordinates(0, 0);
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(color: HexColor('315F5F')),
        child: StreamBuilder<CompassEvent>(
          stream: FlutterCompass.events,
          builder: (context, snapshot) {
            double heading = 0;
            if (snapshot.hasData) {
              heading = snapshot.data!.heading!;
            }
            if (currentPos != null) {
              coordinates =
                  Coordinates(currentPos!.latitude, currentPos!.longitude);
            }
            double? direction = heading - Qibla.qibla(coordinates);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                elevation: 4.0,
                child: Container(
                  padding: const EdgeInsets.all(32),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: HexColor('315F5F').withOpacity(.9),
                    shape: BoxShape.circle,
                  ),
                  child: AnimatedRotation(
                    duration: Duration(milliseconds: 700),
                    turns: -direction / 360,
                    child: Image.asset('Assets/Images/Compass.png'),
                  ),
                ),
              ),
            );
          },
        ),
      )),
    );
  }
}
