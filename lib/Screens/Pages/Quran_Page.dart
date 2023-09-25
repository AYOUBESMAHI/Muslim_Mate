import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:muslim_mate/Models/Surah.dart';
import 'package:muslim_mate/Providers/SuwarProvider.dart';
import 'package:muslim_mate/Widgets/AyahCard.dart';
import 'package:muslim_mate/Widgets/SurahTitleCard.dart';
import 'package:provider/provider.dart';

class QuranPage extends StatefulWidget {
  final int initialSurah;
  final int initialAyah;
  const QuranPage(this.initialSurah, this.initialAyah, {super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#F6F1EB'),
        body: FutureBuilder(
          future:
              Provider.of<SuwarProvider>(context, listen: false).fetchSuwar(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Surah> suwar =
                  Provider.of<SuwarProvider>(context, listen: false).suwar;

              return CarouselSlider(
                  slideTransform: const TabletTransform(),
                  initialPage: widget.initialSurah,
                  children: [
                    ...List.generate(
                        suwar.length,
                        (i) => Scaffold(
                                body: SafeArea(
                              child: CustomScrollView(
                                slivers: [
                                  if (widget.initialSurah != i ||
                                      widget.initialAyah == -1)
                                    SliverToBoxAdapter(
                                        child: SurahTitleCard(suwar[i])),
                                  SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      if (widget.initialAyah > index &&
                                          widget.initialSurah == i) {
                                        return Container();
                                      }
                                      return (i != 0 && i != 8 && index == 0)
                                          ? Image.asset(
                                              'Assets/Images/pngwing.com.png',
                                              color: HexColor('#011840'),
                                            )
                                          : AyahCard(
                                              suwar[i].ayahsArabic[index],
                                              suwar[i].ayahsEnglish[index],
                                              suwar[i]
                                                  .ayahsTransliteration[index],
                                            );
                                    },
                                    childCount: (i != 0 && i != 8)
                                        ? suwar[i].count + 1
                                        : suwar[i].count,
                                  ))
                                ],
                              ),
                            ))),
                  ]);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
