import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

//Model
import '../Models/Mosque.dart';
//Provider
import '../Providers/MosquesProvider.dart';
//Page
import 'Pages/MosquesList_Page.dart';
//Util
import '../Services/GeoLocation_Service.dart';
import '../Utils/Constants.dart';

class MasjidScreen extends StatefulWidget {
  const MasjidScreen({super.key});

  @override
  State<MasjidScreen> createState() => _MasjidScreenState();
}

class _MasjidScreenState extends State<MasjidScreen> {
  late MosquesProvider mosquesProvider;
  List<Mosque> mosques = [];
  bool isSearching = false;
  bool ischanged = false;
  late BitmapDescriptor destination;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition initialPlace = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Set<Marker> markers = <Marker>{};
  Set<Polyline> polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mosquesProvider = Provider.of<MosquesProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!ischanged) {
      destination = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 200), mosqueMapIcon);
      ischanged = true;
    }
  }

  void getNearMosques(LatLng pos) async {
    await mosquesProvider.fethNearMosques(pos);
    mosques = mosquesProvider.mosques;
    showPinsOnTheMap();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
        future: determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            initialPlace = CameraPosition(
              target: LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
              zoom: 16.8,
            );
            if (!isSearching) {
              getNearMosques(initialPlace.target);
              isSearching = true;
            }
            return buildMap();
          }
          return buildLoadingScreen();
        },
      )),
    );
  }

  Widget buildMap() {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Positioned.fill(
              child: GoogleMap(
                myLocationEnabled: true,
                mapType: MapType.normal,
                markers: markers,
                polylines: polylines,
                initialCameraPosition: initialPlace,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            Positioned(
                bottom: 1,
                child: ElevatedButton(
                  child: const Icon(Icons.list),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => MosquesListPage(setPolylines))),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildLoadingScreen() {
    final size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height,
        width: size.width,
        child: Image.asset(
          mosqueLoadImg,
          fit: BoxFit.cover,
        ));
  }

  void showPinsOnTheMap() {
    markers.add(
      Marker(
          markerId: const MarkerId('SourceId'),
          position: initialPlace.target,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
    );
    for (Mosque mosque in mosques) {
      markers.add(
        Marker(
            markerId: MarkerId(mosque.placeId),
            position: mosque.latLng,
            icon: destination,
            onTap: () {
              setPolylines(mosque.latLng);
            }),
      );
    }
    setState(() {});
  }

  void setPolylines(LatLng destination) async {
    polylines.clear();

    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
            FlutterConfig.get('GOOGLE_MAPS_API_KEY'),
            PointLatLng(
                initialPlace.target.latitude, initialPlace.target.longitude),
            PointLatLng(destination.latitude, destination.longitude));
    if (polylineResult.status == 'OK') {
      polylineCoordinates.clear();

      for (var p in polylineResult.points) {
        polylineCoordinates.add(LatLng(p.latitude, p.longitude));
      }

      polylines.add(
        Polyline(
            polylineId: const PolylineId('polyLine'),
            width: 10,
            color: Colors.cyan,
            points: polylineCoordinates),
      );
      setState(() {});
    }
  }
}
