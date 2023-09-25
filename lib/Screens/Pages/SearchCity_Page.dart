import 'package:flutter/material.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:provider/provider.dart';

import '../../Models/City.dart';
import '../../Providers/CitiesProvider.dart';

class SearchCityPage extends StatefulWidget {
  final Function changeCity;
  const SearchCityPage(this.changeCity, {super.key});

  @override
  State<SearchCityPage> createState() => _SearchCityPageState();
}

class _SearchCityPageState extends State<SearchCityPage> {
  final textController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: const InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: textController,
            onChanged: (v) => setState(() {}),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    textController.clear();
                  });
                },
                icon: const Icon(Icons.close))
          ],
        ),
        body: FutureBuilder(
            future:
                Provider.of<CitiesProvider>(context, listen: false).setCities(),
            builder: (ctx, snapshot) {
              List<City> cities = [];
              if (snapshot.connectionState == ConnectionState.done) {
                cities = Provider.of<CitiesProvider>(context).cities;
              }
              List<City> searched = [];
              if (textController.text.isNotEmpty) {
                searched = cities
                    .where((e) => e.name
                        .toString()
                        .toLowerCase()
                        .contains(textController.text.toLowerCase()))
                    .toList();
              } else {
                searched = cities;
              }
              return SizedBox(
                child: ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      widget.changeCity(
                          searched[index].name,
                          Coordinates(
                              searched[index].lat, searched[index].lng));
                      Navigator.pop(context);
                    },
                    title: Text(searched[index].name),
                    subtitle: Text(searched[index].state),
                  ),
                  itemCount: searched.length,
                ),
              );
            }),
      ),
    );
  }
}
