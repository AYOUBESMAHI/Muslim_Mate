class Supplication {
  late int id;
  late int repeat;
  late String body;
  late String bodyVocalized;
  late String note;
  int counter = 0;

  Supplication.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    repeat = json['repeat'];
    body = json['body'];
    bodyVocalized = json['bodyVocalized'];
    note = json['note'];
  }

  double get counterPercentage {
    return counter / repeat;
  }
}
