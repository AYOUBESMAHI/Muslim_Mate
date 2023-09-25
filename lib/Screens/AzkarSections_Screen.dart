import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../Providers/AzkarProvider.dart';
import 'Pages/AzkarCategories_Page.dart';
import '../Widgets/SingleGridSection.dart';

class AzkarSectionScreen extends StatelessWidget {
  const AzkarSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#F6F1EB'),
        body: FutureBuilder(
          future:
              Provider.of<AzkarProvider>(context, listen: false).fethSections(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final sections =
                  Provider.of<AzkarProvider>(context, listen: false).sections;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    const SizedBox(height: 41),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 2,
                        ),
                        itemBuilder: ((context, i) {
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        AzkarCategoriesPage(sections[i]))),
                            child: SingleGridSection(
                                sections[i].icon,
                                sections[i].name,
                                sections[i].categories.length),
                          );
                        }),
                        itemCount: sections.length,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
        ),
      ),
    );
  }
}
