import 'package:flutter/material.dart';
import 'package:kids_math/screens/home.dart';
// ignore: depend_on_referenced_packages
import 'package:nice_buttons/nice_buttons.dart';

class ResultMenu extends StatelessWidget {
  static const routeName = '/result-menu';
  late String score;
  late int totalQuestions;
  late int percentage;
  late Enum operation;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    score = arguments['score'];
    totalQuestions = arguments['totalQuestions'];
    operation = arguments['operation'];
    percentage =
        int.parse(score) != 0 ? (int.parse(score)) * 100 ~/ totalQuestions : 0;
    return Scaffold(
      body: Container(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  child: const Center(
                    child: Text(
                      'Your test results!',
                      style: TextStyle(
                          fontFamily: 'Wonderbar',
                          fontSize: 30,
                          color: Colors.white),
                    ),
                  ),
                ),
                Text(
                  'score :  $score',
                  style: const TextStyle(
                      fontFamily: 'SunnySpellsRegular',
                      fontSize: 40,
                      color: Colors.amber),
                ),
                Text(
                  'Percentage :  $percentage%',
                  style: const TextStyle(
                      fontFamily: 'SunnySpellsRegular',
                      fontSize: 40,
                      color: Colors.amber),
                ),
                const SizedBox(
                  height: 20,
                ),
                NiceButtons(
                  stretch: false,
                  borderColor: Colors.white,
                  startColor: Colors.green,
                  endColor: Colors.green,
                  gradientOrientation: GradientOrientation.Horizontal,
                  onTap: (finish) {
                    Future.delayed(const Duration(microseconds: 800)).then(
                        (value) => Navigator.pushNamedAndRemoveUntil(
                            context, HomePage.routeName, (r) => false));
                  },
                  child: const Text(
                    'Go Home',
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
