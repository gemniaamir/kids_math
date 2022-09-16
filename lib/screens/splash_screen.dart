import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:splash_screen_view/SplashScreenView.dart';
import 'home.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: HomePage(),
      duration: 5000,
      imageSize: 130,
      imageSrc: "assets/images/maths.png",
      text: "Kids Math",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontFamily: 'Wonderbar',
        fontSize: 40.0,
      ),
      colors: const [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );
  }
}
