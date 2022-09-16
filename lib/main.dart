import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kids_math/menu/result_menu.dart';
import 'package:kids_math/menu/settings_menu.dart';
import 'package:kids_math/provider/time.dart';
import 'package:kids_math/screens/excercise.dart';
import 'package:kids_math/screens/home.dart';
import 'package:kids_math/widgets/game_menu.dart';
import 'package:provider/provider.dart';
import 'package:kids_math/screens/splash_screen.dart';
import './screens/levels.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    loadChromeSettings();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TotalTime(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo Application',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          backgroundColor: Colors.pink,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.white, // Your accent color
          ),
          fontFamily: 'AnekTelugu',
          primaryTextTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            titleMedium: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 111, 111, 111),
            ),
          ),
        ),
        home: const MyHomePage(),
        routes: {
          Excercise.routeName: (ctx) => Excercise(),
          HomePage.routeName: (context) => HomePage(),
          GameMenu.routeName: (context) => GameMenu(),
          SettingsMenu.routeName: (context) => SettingsMenu(),
          LevelScreen.routeName: (context) => LevelScreen(),
          ResultMenu.routeName: (context) => ResultMenu(),
        },
      ),
    );
  }

  void loadChromeSettings() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
