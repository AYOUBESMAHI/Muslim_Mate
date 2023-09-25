import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../Models/Category.dart';
import '../../Models/Section.dart';
import '../../Providers/AzkarProvider.dart';
import 'AzkarSupplication_Page.dart';

class AzkarCategoriesPage extends StatelessWidget {
  final Section section;
  const AzkarCategoriesPage(this.section, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#F6F1EB'),
        body: FutureBuilder(
          future: Provider.of<AzkarProvider>(context, listen: false)
              .fethCategories(section.categories),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final categories = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ListView.builder(
                  itemBuilder: (_, i) => GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              AzkarSupplicationPage(categories[i]))),
                      child: singleCategoryTile(categories, i)),
                  itemCount: categories.length,
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget singleCategoryTile(List<Category> categories, int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
      child: ListTile(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: Colors.white,
        title: Text(
          categories[i].name,
          textDirection: TextDirection.rtl,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        trailing: Image.asset(section.icon),
      ),
    );
  }
}
