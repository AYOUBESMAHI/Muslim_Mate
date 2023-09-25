import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:muslim_mate/Providers/SuwarProvider.dart';
import 'package:muslim_mate/Widgets/JuzListeTile.dart';
import 'package:muslim_mate/Widgets/SurahLiteTile.dart';
import 'package:provider/provider.dart';

import '../Models/Surah.dart';

class QuranListScreen extends StatefulWidget {
  const QuranListScreen({super.key});

  @override
  State<QuranListScreen> createState() => _QuranListScreenState();
}

class _QuranListScreenState extends State<QuranListScreen>
    with TickerProviderStateMixin {
  late TabController _controller;
  List<Surah> suwar = [];
  bool isChanged = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!isChanged) {
      await Provider.of<SuwarProvider>(context, listen: false).fetchSuwar();
      suwar = Provider.of<SuwarProvider>(context, listen: false).suwar;

      setState(() {
        isChanged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#F6F1EB'),
        appBar: AppBar(
          backgroundColor: HexColor('#011840'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "The Quran",
            style: TextStyle(
                color: HexColor('#F7D000'),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
              controller: _controller,
              onTap: (value) => setState(() {}),
              tabs: const [
                Tab(
                    child: Text('Surah',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                Tab(
                    child: Text('Juzz',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ]),
        ),
        body: isChanged
            ? _controller.index == 0
                ? buildListSuwar(suwar)
                : buildListJuz(context)
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

Widget buildListSuwar(List<Surah> suwar) {
  return ListView.builder(
    itemBuilder: (_, i) =>
        SurahListTile(i + 1, suwar[i].title, suwar[i].count, suwar[i].titleAr),
    itemCount: suwar.length,
  );
}

Widget buildListJuz(BuildContext context) {
  return FutureBuilder(
      future: Provider.of<SuwarProvider>(context, listen: false).fethJuz(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.done) {
          final juz = Provider.of<SuwarProvider>(context, listen: false).juz;

          return ListView.builder(
            itemBuilder: ((context, i) =>
                JuzListTile(juz[i]['id'], juz[i]['suwarIn'])),
            itemCount: juz.length,
          );
        }
        return const Center(child: CircularProgressIndicator());
      });
}
