class Category {
  late int id;
  late int weight;
  late String name;
  late String nameSearch;
  late List<int> supplications;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weight = json['weight'];
    name = json['name'];
    nameSearch = json['nameSearch'];
    supplications = [];
    json['supplications'].forEach((v) {
      supplications.add(v['id']);
    });
  }
}
