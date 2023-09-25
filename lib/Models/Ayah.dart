class Ayah {
  late int number;
  late String audio;
  late List<String> audioSecondary;
  late String text;
  late String ayaTextEmlaey;
  late int numberInSurah;
  late int juz;
  late int manzil;
  late int page;
  late int pageInSurah;
  late int ruku;
  late int hizbQuarter;
  // late bool sajda;

  Ayah.fromJson(Map<String, dynamic> json) {
    try {
      number = json['number'];
      audio = json['audio'];
      audioSecondary = json['audioSecondary'].cast<String>();
      text = json['text'];
      ayaTextEmlaey = json['aya_text_emlaey'];
      numberInSurah = json['numberInSurah'];
      juz = json['juz'];
      manzil = json['manzil'];
      page = json['page'];
      pageInSurah = json['pageInSurah'];
      ruku = json['ruku'];
      hizbQuarter = json['hizbQuarter'];
      //  sajda = json['sajda'];
    } catch (err) {
      print('Ayah.fromJson error $err');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['audio'] = audio;
    data['audioSecondary'] = audioSecondary;
    data['text'] = text;
    data['aya_text_emlaey'] = ayaTextEmlaey;
    data['numberInSurah'] = numberInSurah;
    data['juz'] = juz;
    data['manzil'] = manzil;
    data['page'] = page;
    data['pageInSurah'] = pageInSurah;
    data['ruku'] = ruku;
    data['hizbQuarter'] = hizbQuarter;
    //data['sajda'] = sajda;
    return data;
  }
}
