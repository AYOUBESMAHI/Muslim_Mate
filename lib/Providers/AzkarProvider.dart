import 'package:flutter/material.dart';
import 'package:muslim_mate/Models/Section.dart';
import 'package:muslim_mate/Models/Supplication.dart';
import 'package:muslim_mate/Utils/Helpers.dart';

import '../Models/Category.dart';

class AzkarProvider extends ChangeNotifier {
  List<Section> sections = [];
  List<Category> categories = [];
  List<Supplication> supplications = [];

  Future<void> fethSections() async {
    if (sections.isNotEmpty) {
      return;
    }
    final sectionsData =
        await fetchListFromJson('Assets/Data/Azkar/Section.json');
    sections = sectionsData.map((e) => Section.fromJson(e)).toList();
    notifyListeners();
  }

  Future<List<Category>> fethCategories(List<int> ids) async {
    if (categories.isEmpty) {
      final categoriesData =
          await fetchListFromJson('Assets/Data/Azkar/Category.json');

      categories = categoriesData.map((e) => Category.fromJson(e)).toList();
    }

    return categories.where((c) => ids.contains(c.id)).toList();
  }

  Future<List<Supplication>> fethSupplications(List<int> ids) async {
    final supplicationsData =
        await fetchListFromJson('Assets/Data/Azkar/Supplication.json');

    supplications =
        supplicationsData.map((e) => Supplication.fromJson(e)).toList();

    return supplications.where((c) => ids.contains(c.id)).toList();
  }
}
