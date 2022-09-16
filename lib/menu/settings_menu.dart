import 'package:flutter/material.dart';
import 'package:kids_math/screens/excercise.dart';
import 'package:kids_math/screens/home.dart';
// ignore: depend_on_referenced_packages
import 'package:nice_buttons/nice_buttons.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

class SettingsMenu extends StatefulWidget {
  static const routeName = '/settings-menu';

  final dissmissKey = GlobalKey();

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  late Function updateTimeValue;
  late int currentValue;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    currentValue = arguments['interval'] as int;
    updateTimeValue = arguments['updateFunc'] as Function;

    return Scaffold(
      body: Container(
        color: Colors.amber,
        height: size.height,
        width: size.width,
        child: Stack(children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
              child: Container(
            color: Colors.black54,
          )),
          Container(
            width: size.width,
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Update test time!',
                  style: TextStyle(
                      fontFamily: 'Wonderbar',
                      fontSize: 30,
                      color: Colors.white),
                ),
                CustomNumberPicker(
                  initialValue: currentValue,
                  maxValue: 180,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide.none,
                  ),
                  customMinusButton:
                      Image.asset('assets/images/minus_circle.png', height: 40),
                  customAddButton:
                      Image.asset('assets/images/add_circle.png', height: 40),
                  valueTextStyle: const TextStyle(
                      fontFamily: 'Wonderbar',
                      fontSize: 40,
                      color: Colors.amber),
                  minValue: 30,
                  step: 10,
                  onValue: (value) {
                    currentValue = value as int;
                  },
                ),
                NiceButtons(
                  startColor: Colors.pinkAccent,
                  endColor: Colors.pink,
                  borderColor: Colors.amberAccent,
                  stretch: false,
                  gradientOrientation: GradientOrientation.Horizontal,
                  onTap: (finish) {
                    updateTimeValue(currentValue);
                    Future.delayed(const Duration(seconds: 1))
                        .then((value) => Navigator.pop(context));
                  },
                  child: const Text(
                    'Update Time',
                    style: TextStyle(
                        fontFamily: 'Wonderbar',
                        color: Colors.white,
                        fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
