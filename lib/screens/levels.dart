import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kids_math/constants/constants.dart';
import 'package:kids_math/screens/excercise.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelScreen extends StatelessWidget {
  static const routeName = '/levels-screen';
  late SharedPreferences prefs;
  Map<String, List<String>> levels = {};
  String levelKey = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    late Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Enum operation = arguments['operation'] as Enum;
    int currentInterval = arguments['interval'] as int;

    return Scaffold(
        body: Container(
      color: Colors.white54,
      child: FutureBuilder(
        future: initSharedPrefAndReturnLevel(operation),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: Text('Please wait, loading'));

            case ConnectionState.done:
              if (snapshot.hasData) {
                final data = snapshot.data as List<String>;
                return GridView.count(
                  padding: const EdgeInsets.only(
                      top: (50), left: 20, right: 20, bottom: 20),
                  crossAxisCount: 4,
                  mainAxisSpacing: 50.0,
                  crossAxisSpacing: 50.0,
                  children: List.generate(
                    10,
                    (index) => InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Excercise.routeName,
                          arguments: {
                            'operation': operation,
                            'interval': currentInterval,
                            'level': index,
                            'level_key': levelKey,
                            'level_list': levels[levelKey]
                          },
                        );
                      },
                      child: Ink(
                        color: Colors.transparent,
                        child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          clipBehavior: Clip.hardEdge,
                          color: Colors.amberAccent,
                          shadowColor: Colors.pink,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Level ${index + 1}',
                                style: const TextStyle(
                                    fontFamily: 'SunnySpellsRegular',
                                    fontSize: 24,
                                    color: Colors.black54),
                              ),
                              RatingBar.builder(
                                glowColor: Colors.white,
                                initialRating: double.parse(
                                    getAcheivementStars(data[index])),
                                minRating: 0.5,
                                direction: Axis.horizontal,
                                itemSize: size.width > 750 ? 35 : 30,
                                allowHalfRating: true,
                                ignoreGestures: true,
                                itemCount: 3,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.pink,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              Text(
                                'Pass: ${getPercentageText(data[index])}%',
                                style: const TextStyle(
                                    fontFamily: 'SunnySpellsRegular',
                                    fontSize: 24,
                                    color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Some error occurred'));
              } else {
                return const Center(child: Text('Some error occurred'));
              }
            case ConnectionState.none:
              return const Center(child: Text('Please wait, loading'));
            case ConnectionState.active:
              return const Center(child: Text('Please wait, loading'));
          }
        },
      ),
    ));
  }

  Future<List<String>> initSharedPrefAndReturnLevel(operation) async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('Addition') &&
        prefs.containsKey('Subtract') &&
        prefs.containsKey('Multiply') &&
        prefs.containsKey('Divide')) {
      levels = {
        'Addition': prefs.getStringList('Addition') as List<String>,
        'Subtract': prefs.getStringList('Subtract') as List<String>,
        'Multiply': prefs.getStringList('Multiply') as List<String>,
        'Divide': prefs.getStringList('Divide') as List<String>,
      };
    } else {
      await prefs.setStringList('Addition', List.filled(10, '0,0'));
      await prefs.setStringList('Subtract', List.filled(10, '0,0'));
      await prefs.setStringList('Multiply', List.filled(10, '0,0'));
      await prefs.setStringList('Divide', List.filled(10, '0,0'));

      levels = {
        'Addition': prefs.getStringList('Addition') as List<String>,
        'Subtract': prefs.getStringList('Subtract') as List<String>,
        'Multiply': prefs.getStringList('Multiply') as List<String>,
        'Divide': prefs.getStringList('Divide') as List<String>,
      };
    }

    switch (operation) {
      case Operation.Add:
        levelKey = 'Addition';
        return levels['Addition'] as List<String>;
      case Operation.Divide:
        levelKey = 'Divide';
        return levels['Divide'] as List<String>;
      case Operation.Multiply:
        levelKey = 'Multiply';
        return levels['Multiply'] as List<String>;
      case Operation.Subtract:
        levelKey = 'Subtract';
        return levels['Subtract'] as List<String>;
    }

    return levels['Addition'] as List<String>;
  }

  String getPercentageText(String temp) {
    final tempArray = temp.split(',');
    return tempArray[1];
  }

  String getAcheivementStars(String temp) {
    final tempArray = temp.split(',');
    return tempArray[0];
  }
}
