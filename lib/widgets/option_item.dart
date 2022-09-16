import 'dart:ui';

import 'package:flutter/material.dart';

class OptionItem extends StatefulWidget {
  double option;
  final color;
  final operation;
  final Function checkAnswer;

  OptionItem(
    this.option,
    this.color,
    this.checkAnswer,
    this.operation,
  );

  @override
  State<OptionItem> createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        widget.checkAnswer(
          widget.option,
          widget.operation,
        );
      },
      child: Container(
        width: 100,
        alignment: Alignment.center,
        child: Text(
          widget.option.toStringAsFixed(0),
          style: TextStyle(
              fontSize: 50,
              color: widget.color,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
