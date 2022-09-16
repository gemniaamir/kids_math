// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kids_math/constants/constants.dart';
import 'package:kids_math/screens/excercise.dart';
import 'package:kids_math/screens/levels.dart';

class OperationButton extends StatefulWidget {
  final icon;
  final verticalPadding;
  final operation;
  final currentInterval;

  const OperationButton({
    Key? key,
    required this.icon,
    required this.verticalPadding,
    required this.operation,
    required this.currentInterval,
  }) : super(key: key);

  @override
  State<OperationButton> createState() => _OperationButtonState();
}

class _OperationButtonState extends State<OperationButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final Tween<double> _tween = Tween(begin: 0.75, end: 1);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ScaleTransition(
        scale: _tween.animate(
            CurvedAnimation(parent: _controller, curve: Curves.elasticOut)),
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: widget.verticalPadding),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  LevelScreen.routeName,
                  arguments: {
                    'operation': widget.operation,
                    'interval': widget.currentInterval
                  },
                );
              },
              child: Image.asset(
                widget.icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
