import 'package:flutter/material.dart';
import 'package:kids_math/widgets/option_item.dart';

class Options extends StatelessWidget {
  const Options({
    Key? key,
    required this.size,
    required this.safePadding,
    required this.optionOne,
    required this.optionTwo,
    required this.optionThree,
    required this.optionFour,
    required this.checkAnswer,
    required this.operation,
  }) : super(key: key);

  final Size size;
  final double safePadding;
  final double optionOne;
  final double optionTwo;
  final double optionThree;
  final double optionFour;
  final Function checkAnswer;
  final Enum operation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width - 20,
      height: (size.height - safePadding - 40) * 0.20,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        OptionItem(optionOne, Colors.green, checkAnswer, operation),
        OptionItem(optionTwo, Colors.red, checkAnswer, operation),
        OptionItem(optionThree, Colors.blue, checkAnswer, operation),
        OptionItem(optionFour, Colors.amber, checkAnswer, operation),
      ]),
    );
  }
}
