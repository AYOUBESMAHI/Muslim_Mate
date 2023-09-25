import 'package:flutter/material.dart';
import 'package:muslim_mate/Models/Surah.dart';
import 'package:muslim_mate/Utils/Helpers.dart';

class SuwarProvider extends ChangeNotifier {
  List<Surah> suwar = [];
  List<Map<String, dynamic>> juz = [];

  Future<void> fetchSuwar() async {
    if (suwar.isNotEmpty) {
      return;
    }

    final surahData = await fetchListFromJson("Assets/Data/Quran/surah.json");

    suwar = surahData.map((e) => Surah.fromJson(e)).toList();

    for (var surah in suwar) {
      final arabicData = await fetchMapFromJson('Assets/Data/Quran/quran.json');
      final engData = await fetchMapFromJson('Assets/Data/Quran/en.json');
      final transData =
          await fetchMapFromJson('Assets/Data/Quran/transliteration.json');

      surah.ayahsArabic = (arabicData["${surah.index}"] as List)
          .map((e) => e["text"].toString())
          .toList();
      surah.ayahsEnglish = (engData["${surah.index}"] as List)
          .map((e) => e["text"].toString())
          .toList();
      surah.ayahsTransliteration = (transData["${surah.index}"] as List)
          .map((e) => e["text"].toString())
          .toList();
    }
    notifyListeners();
  }

  Future<void> fethJuz() async {
    if (juz.isNotEmpty) {
      return;
    }
    final juzData = await fetchListFromJson("Assets/Data/Quran/juz.json");

    for (int i = 0; i < juzData.length; i++) {
      int id = juzData[i]["id"];
      Map<String, dynamic> start = juzData[i]["start"];
      Map<String, dynamic> end = juzData[i]["end"];
      List<Map<String, dynamic>> suwarIn = [];
      if (start["sura"] != end["sura"]) {
        suwarIn.add({
          'index': suwar[start["sura"] - 1].index,
          'Title': suwar[start["sura"] - 1].title,
          'ayahStart': start["verse"],
          'ayahEnd': suwar[start["sura"] - 1].count,
        });
        for (int j = start["sura"]; j < end["sura"] - 1; j++) {
          suwarIn.add({
            'index': suwar[j].index,
            'Title': suwar[j].title,
            'ayahStart': 1,
            'ayahEnd': suwar[j].count,
          });
        }
        suwarIn.add({
          'index': suwar[end["sura"] - 1].index,
          'Title': suwar[end["sura"] - 1].title,
          'ayahStart': 1,
          'ayahEnd': end["verse"]
        });
      } else {
        suwarIn.add({
          'index': suwar[start["sura"] - 1].index,
          'Title': suwar[start["sura"] - 1].title,
          'ayahStart': start["verse"],
          'ayahEnd': end["verse"],
        });
      }
      juz.add({'id': id, 'suwarIn': suwarIn, 'count': suwarIn.length});
    }
    notifyListeners();
  }
}
