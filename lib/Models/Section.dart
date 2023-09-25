class Section {
  late int id;
  late int weight;
  late String name;
  late String icon;
  List<int> categories = [];

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weight = json['weight'];
    name = json['name'];
    icon = json['icon'];
    categories = [];
    json['categories'].forEach((v) {
      categories.add(v['id']);
    });
  }
}
