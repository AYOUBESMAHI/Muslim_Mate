import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
//Models
import '../../Models/Category.dart';
import '../../Models/Supplication.dart';
//Provider
import '../../Providers/AzkarProvider.dart';
//Widgets
import '../../Widgets/SingleSupplication.dart';

class AzkarSupplicationPage extends StatefulWidget {
  final Category category;
  const AzkarSupplicationPage(this.category, {super.key});

  @override
  State<AzkarSupplicationPage> createState() => _AzkarSupplicationPageState();
}

class _AzkarSupplicationPageState extends State<AzkarSupplicationPage> {
  final _controller = PageController();
  List<Supplication> supplications = [];
  bool isChanged = false;
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!isChanged) {
      supplications = await Provider.of<AzkarProvider>(context)
          .fethSupplications(widget.category.supplications);
      setState(() {
        isChanged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#F6F1EB'),
        body: isChanged
            ? PageView.builder(
                controller: _controller,
                reverse: true,
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () {
                      if (supplications[i].counter < supplications[i].repeat) {
                        supplications[i].counter++;
                        Vibration.vibrate();

                        setState(() {});
                      }
                      if (i < supplications.length - 1 &&
                          supplications[i].counter == supplications[i].repeat) {
                        i++;
                        _controller.animateToPage(i,
                            duration: Duration(milliseconds: 1200),
                            curve: Curves.linear);
                      }
                    },
                    child: SingleSupplication(supplications[i]),
                  );
                },
                itemCount: supplications.length,
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
