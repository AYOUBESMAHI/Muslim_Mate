import 'package:flutter/material.dart';
import 'package:muslim_mate/Models/Mosque.dart';
import 'package:muslim_mate/Providers/MosquesProvider.dart';
import 'package:muslim_mate/Utils/Constants.dart';
import 'package:provider/provider.dart';

class MosquesListPage extends StatelessWidget {
  final Function setPolylines;
  const MosquesListPage(this.setPolylines, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Mosque> mosques = Provider.of<MosquesProvider>(context).mosques;
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: ListView.builder(
            itemBuilder: (ctx, i) => ListTile(
              onTap: () {
                setPolylines(mosques[i].latLng);
                Navigator.pop(context);
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.cyan.shade200,
                backgroundImage: const AssetImage(mosqueMapImg),
              ),
              title: Text(
                mosques[i].name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(mosques[i].descritption),
              trailing: Text(distanceToString(mosques[i].distance)),
            ),
            itemCount: mosques.length,
          ),
        ),
      ),
    );
  }
}

String distanceToString(double distance) {
  if (distance < 1) {
    double newval = distance * 1000;
    return '${newval.toStringAsFixed(0)} Meters';
  }
  return '${distance.toStringAsFixed(1)} kms';
}
