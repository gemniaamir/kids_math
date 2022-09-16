import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:animated_check/animated_check.dart';
import 'package:animated_cross/animated_cross.dart';
import 'package:kids_math/constants/constants.dart';

class Question extends StatelessWidget {
  Question({
    Key? key,
    required this.size,
    required this.safePadding,
    required this.firstValue,
    required this.secondValue,
    required this.tickAnimation,
    required this.crossAnimation,
    required this.operation,
  }) : super(key: key);

  final Size size;
  final double safePadding;
  final int firstValue;
  final int secondValue;
  late Animation<double> tickAnimation;
  late Animation<double> crossAnimation;
  Enum operation;
  late String operationString;

  @override
  Widget build(BuildContext context) {
    operationString = getOperationString();
    return Container(
      width: size.width,
      height: (size.height - safePadding - 40) * 0.60,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCross(
              color: Colors.redAccent,
              progress: crossAnimation,
              size: 150,
            ),
            Text(
              '$firstValue $operationString $secondValue = ?',
              style: const TextStyle(
                  fontSize: 80,
                  color: Colors.black87,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold),
            ),
            AnimatedCheck(
              color: Colors.greenAccent,
              progress: tickAnimation,
              size: 150,
            ),
          ],
        ),
      ),
    );
  }

  String getOperationString() {
    if (operation == Operation.Add) {
      return '+';
    }
    if (operation == Operation.Divide) {
      return '÷';
    }
    if (operation == Operation.Multiply) {
      return 'x';
    }
    if (operation == Operation.Subtract) {
      return '-';
    }
    return '+';
  }
}
