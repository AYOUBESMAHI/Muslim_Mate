class Prayer {
  late String name;
  late DateTime time;
  Prayer(this.name, this.time);
  Prayer.mapToPrayer(Map<String, dynamic> map) {
    name = map["name"];
    time = DateTime.parse(map["time"]);
  }

  Map<String, String> prayerToMap() {
    return {
      "name": name,
      "time": time.toIso8601String(),
    };
  }

  Duration getDuration() {
    var now = DateTime.now();

    int totalSecondsDifference = time.difference(now).inSeconds;
    int days = totalSecondsDifference ~/ (60 * 60 * 24);
    int hours = (totalSecondsDifference ~/ (60 * 60)) % 24;
    int minutes = (totalSecondsDifference ~/ 60) % 60;
    int seconds = totalSecondsDifference % 60;

    return Duration(
        days: days, hours: hours, minutes: minutes, seconds: seconds);
  }
}
