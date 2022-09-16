import 'package:flutter/material.dart';
import 'package:kids_math/screens/excercise.dart';
import 'package:kids_math/screens/home.dart';
// ignore: depend_on_referenced_packages
import 'package:nice_buttons/nice_buttons.dart';

class GameMenu extends StatelessWidget {
  const GameMenu({Key? key}) : super(key: key);
  static const routeName = '/game-menu';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  'Do you want to resume test? Or Quit!',
                  style: TextStyle(
                      fontFamily: 'Wonderbar',
                      fontSize: 30,
                      color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NiceButtons(
                      startColor: Colors.pinkAccent,
                      endColor: Colors.pink,
                      borderColor: Colors.amberAccent,
                      stretch: false,
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (finish) {
                        Future.delayed(const Duration(microseconds: 800)).then(
                            (value) => Navigator.pushNamedAndRemoveUntil(
                                context, HomePage.routeName, (r) => false));
                      },
                      child: const Text(
                        'Quit',
                        style: TextStyle(
                            fontFamily: 'Wonderbar',
                            color: Colors.white,
                            fontSize: 24),
                      ),
                    ),
                    NiceButtons(
                      stretch: false,
                      borderColor: Colors.white,
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (finish) {
                        Future.delayed(const Duration(microseconds: 800))
                            .then((value) => Navigator.pop(
                                  context,
                                ));
                      },
                      child: const Text(
                        'Resume',
                        style: TextStyle(
                            fontFamily: 'Wonderbar',
                            color: Colors.white,
                            fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
