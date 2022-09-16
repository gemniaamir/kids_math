import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kids_math/constants/constants.dart';
import 'package:kids_math/menu/result_menu.dart';

import 'package:kids_math/widgets/header_row.dart';
import 'package:kids_math/widgets/options.dart';
import 'package:kids_math/widgets/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Excercise extends StatefulWidget {
  static const String routeName = '/excercise-screen';

  @override
  State<Excercise> createState() => _ExcerciseState();
}

class _ExcerciseState extends State<Excercise> with TickerProviderStateMixin {
  int firstValue = 0;
  int secondValue = 0;
  int rightOptionIndex = 0;
  double optionOne = 0;
  double optionTwo = 0;
  double optionThree = 0;
  double optionFour = 0;
  int score = 0;
  int totalQuestionCount = 0;
  bool isTestRunning = true;
  late Map<String, dynamic> arguments;
  late Enum operation;
  late int currentInterval;
  late String levelKey;
  late int level;
  late List<String> levelList;

  late AnimationController _tickAnimationController, _crossAnimationController;
  late Animation<double> _tickAnimation, _crossAnimation;

  var isInit = true;

  @override
  void initState() {
    super.initState();

    _tickAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _crossAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      _tickAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _tickAnimationController, curve: Curves.easeInOutCirc));
      _crossAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _crossAnimationController, curve: Curves.easeInOutCirc));
      arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      operation = arguments['operation'] as Enum;
      currentInterval = arguments['interval'] as int;
      level = arguments['level'] as int;
      levelKey = arguments['level_key'] as String;
      levelList = arguments['level_list'] as List<String>;
    } else {
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tickAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (operation == Operation.Divide) {
      int tempOne = getRandomNumber(5) * (level + 1);
      int tempTwo = getRandomNumber(5) * (level + 1);
      firstValue = (tempOne + 1) * (tempTwo + 1);
      secondValue = tempTwo + 1;
    } else if (operation == Operation.Subtract) {
      firstValue =
          getRandomNumber(10) + 1 + (level <= 5 ? (level * 4) : (level * 10));
      secondValue = getRandomNumber(firstValue) + 1;
    } else {
      firstValue =
          getRandomNumber(5) + 1 + (level <= 5 ? (level * 4) : (level * 10));
      secondValue =
          getRandomNumber(5) + 1 + (level <= 5 ? (level * 4) : (level * 10));
    }
    rightOptionIndex = getRightOption();
    optionOne = getOptionsValues(0, firstValue, secondValue);
    optionTwo = getOptionsValues(1, firstValue, secondValue);
    optionThree = getOptionsValues(2, firstValue, secondValue);
    optionFour = getOptionsValues(3, firstValue, secondValue);

    final size = MediaQuery.of(context).size;
    var safePadding = MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Scaffold(
        body: Material(
          shape: const Border(
            right: BorderSide(
              width: 7,
              color: Colors.red,
            ),
            left: BorderSide(
              width: 7,
              color: Colors.green,
            ),
            bottom: BorderSide(
              width: 7,
              color: Colors.blue,
            ),
            top: BorderSide(
              width: 7,
              color: Colors.yellow,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: size.width,
              height: size.height - safePadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width,
                    height: (size.height - safePadding - 40) * 0.20,
                    child: Row(
                      children: [
                        HeaderRow(
                            score, presentResult, currentInterval, operation),
                      ],
                    ),
                  ),
                  Question(
                    size: size,
                    safePadding: safePadding,
                    firstValue: firstValue,
                    secondValue: secondValue,
                    tickAnimation: _tickAnimation,
                    crossAnimation: _crossAnimation,
                    operation: operation,
                  ),
                  Options(
                    size: size,
                    safePadding: safePadding,
                    optionOne: optionOne,
                    optionTwo: optionTwo,
                    optionThree: optionThree,
                    optionFour: optionFour,
                    checkAnswer: checkAnswer,
                    operation: operation,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int getRandomNumber(int range) {
    return Random().nextInt(range);
  }

  int getRightOption() {
    return Random().nextInt(4);
  }

  double getOptionsValues(int optionIndex, int firstValue, int secondValue) {
    if (rightOptionIndex == optionIndex) {
      if (operation == Operation.Add) {
        return (firstValue.toDouble()) + (secondValue.toDouble());
      }
      if (operation == Operation.Divide) {
        return (firstValue.toDouble()) / (secondValue.toDouble());
      }
      if (operation == Operation.Multiply) {
        return (firstValue.toDouble()) * (secondValue.toDouble());
      }
      if (operation == Operation.Subtract) {
        return (firstValue.toDouble()) - (secondValue.toDouble());
      }
      return 0;
    } else {
      int temp =
          Random().nextInt(getFalseOptionsRange(firstValue, secondValue));
      double random = temp.toDouble();
      do {
        int temp =
            Random().nextInt(getFalseOptionsRange(firstValue, secondValue));

        random = temp.toDouble();
      } while (random == getRightAnswer());
      return random;
    }
  }

  double getRightAnswer() {
    if (operation == Operation.Add) {
      return (firstValue.toDouble()) + (secondValue.toDouble());
    }
    if (operation == Operation.Divide) {
      return (firstValue.toDouble()) / (secondValue.toDouble());
    }
    if (operation == Operation.Multiply) {
      return (firstValue.toDouble()) * (secondValue.toDouble());
    }
    if (operation == Operation.Subtract) {
      return (firstValue.toDouble()) - (secondValue.toDouble());
    }
    return 0;
  }

  int getFalseOptionsRange(firstValue, secondValue) {
    switch (operation) {
      case Operation.Add:
        return firstValue + secondValue + 10;
      case Operation.Subtract:
        return firstValue + 10;
      case Operation.Multiply:
        return (firstValue * secondValue + 10) - firstValue;
      case Operation.Divide:
        return (secondValue) + 10;
    }
    return 10;
  }

  void checkAnswer(double selectedOption, Enum operation) {
    if (isTestRunning) {
      totalQuestionCount++;
      double rightAnswer = 0.0;

      if (operation == Operation.Add) {
        rightAnswer = (firstValue + secondValue).toDouble();
      }
      if (operation == Operation.Divide) {
        rightAnswer = (firstValue.toDouble()) / (secondValue.toDouble());
      }
      if (operation == Operation.Multiply) {
        rightAnswer = (firstValue * secondValue).toDouble();
      }
      if (operation == Operation.Subtract) {
        rightAnswer = (firstValue - secondValue).toDouble();
      }

      if ((rightAnswer) == selectedOption) {
        score++;
        _crossAnimationController.reset();
        _tickAnimationController.forward();
        Future.delayed(const Duration(seconds: 2)).whenComplete(
          () {
            setState(() {
              _tickAnimationController.reset();
            });
          },
        );
      } else {
        score;
        _tickAnimationController.reset();
        _crossAnimationController.forward();
        Future.delayed(const Duration(seconds: 2)).whenComplete(
          () {
            _crossAnimationController.reset();
          },
        );
      }
    }
  }

  void presentResult(ctx) async {
    isTestRunning = false;
    final prefs = await SharedPreferences.getInstance();
    String achievement = '0';
    int percent = score != 0 ? (score) * 100 ~/ totalQuestionCount : 0;
    if (percent < 35) {
      achievement = '1,$percent';
    } else if (percent > 35 && percent < 70) {
      achievement = '2,$percent';
    } else if (percent > 70) {
      achievement = '3,$percent';
    } else {
      achievement = '0,$percent';
    }

    levelList[level] = achievement.toString();
    await prefs.setStringList(levelKey, levelList);

    Navigator.pushNamed(ctx, ResultMenu.routeName, arguments: {
      'score': score.toString(),
      'totalQuestions': totalQuestionCount,
      'operation': operation,
    });
  }
}
