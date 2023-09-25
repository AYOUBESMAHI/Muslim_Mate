class Surah {
  late String type;
  late String title;
  late String titleAr;
  late String englishNameTranslation;
  late int index;
  late int count;
  List<String> ayahsArabic = [];
  List<String> ayahsEnglish = [];
  List<String> ayahsTransliteration = [];

  Surah.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    titleAr = json['titleAr'];
    englishNameTranslation = json['englishNameTranslation'];
    index = json['index'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['titleAr'] = titleAr;
    data['englishNameTranslation'] = englishNameTranslation;
    data['index'] = index;
    data['count'] = index;

    return data;
  }
}
