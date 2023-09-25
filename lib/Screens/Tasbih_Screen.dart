import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:muslim_mate/Utils/Constants.dart';
import 'package:muslim_mate/Utils/Helpers.dart';
import 'package:muslim_mate/Widgets/NumberPickers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vibration/vibration.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  final _pageController = PageController();
  final _textController = TextEditingController();
  List<String> tasbihs = [];
  bool isInitialized = false;
  int _currentValue = 3;
  int maxValue = 100;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!isInitialized) {
      try {
        final data = await fetchListFromJson("Assets/Data/TSABIH.JSON");
        tasbihs = data.map((e) => e["dikr"].toString()).toList();
        setState(() {
          isInitialized = true;
        });
      } catch (err) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _textController.text = maxValue.toString();

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#F6F1EB'),
        body: Center(
          child: !isInitialized
              ? const CircularProgressIndicator()
              : buildTasbihContent(),
        ),
      ),
    );
  }

  Widget buildTasbihContent() {
    return Column(
      children: [
        buildTasbihPageView(),
        SmoothPageIndicator(
            controller: _pageController, // PageController
            count: 24,
            effect: const ScrollingDotsEffect(), // your preferred effect
            onDotClicked: (index) {
              setState(() {
                _pageController.animateToPage(index,
                    duration: const Duration(microseconds: 100),
                    curve: Curves.easeIn);
              });
            }),
        const SizedBox(height: 20),
        buildSetGoalSection(),
        const Spacer(),
        buildNumberPickers(),
        const Spacer(),
        buildCurrentValueDisplay(),
        const SizedBox(height: 4),
        buildFingerprintImage(),
        const Spacer(),
      ],
    );
  }

  Widget buildTasbihPageView() {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (ctx, i) => buildTasbihContainer(tasbihs[i]),
        itemCount: 24,
      ),
    );
  }

  Widget buildTasbihContainer(String tasbih) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          tasbih,
          textAlign: TextAlign.justify,
          textDirection: TextDirection.rtl,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
    );
  }

  Widget buildSetGoalSection() {
    return Column(
      children: [
        Text(
          "Set Goal",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildImageButton(minimizeIcon, () => decrementMaxValue()),
            const SizedBox(width: 3),
            buildGoalTextField(),
            const SizedBox(width: 3),
            buildImageButton(addIcon, () => incrementMaxValue()),
          ],
        ),
      ],
    );
  }

  Widget buildImageButton(String image, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 50,
        height: 50,
        child: Image.asset(image),
      ),
    );
  }

  Widget buildGoalTextField() {
    return SizedBox(
      width: 80,
      height: 50,
      child: TextField(
        controller: _textController,
        decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(5),
        ],
        onSubmitted: (val) {
          setState(() {
            maxValue = int.parse(val);
            maxValue = maxValue.clamp(7, 10000);
          });
        },
      ),
    );
  }

  void decrementMaxValue() {
    setState(() {
      maxValue--;
      maxValue = maxValue.clamp(7, 10000);
    });
  }

  void incrementMaxValue() {
    setState(() {
      maxValue++;
      maxValue = maxValue.clamp(7, 10000);
    });
  }

  Widget buildNumberPickers() {
    return NumberPickers(
      axis: Axis.horizontal,
      value: _currentValue,
      minValue: 0,
      maxValue: maxValue,
      onChanged: (value) {
        Vibration.vibrate();

        setState(() => _currentValue = value);
      },
    );
  }

  Widget buildCurrentValueDisplay() {
    return Column(
      children: [
        Text(
          '$_currentValue',
          style: TextStyle(
            fontSize: 43,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
      ],
    );
  }

  Widget buildFingerprintImage() {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          _currentValue++;
          _currentValue = _currentValue.clamp(0, maxValue);
          Vibration.vibrate();
          setState(() {});
        },
        child: Image.asset(fingerPrint),
      ),
    );
  }
}
