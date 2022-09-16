// ignore: depend_on_referenced_packages
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart' as timer;

import 'package:kids_math/widgets/game_menu.dart';

class HeaderRow extends StatefulWidget {
  int score = 0;
  Function presentResult;
  late int currentInterval;
  Enum operation;

  HeaderRow(
      this.score, this.presentResult, this.currentInterval, this.operation);

  @override
  State<HeaderRow> createState() => _HeaderRowState();
}

class _HeaderRowState extends State<HeaderRow> {
  bool isTimeRunning = true;
  final CountdownController _controller = CountdownController(autoStart: true);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (() {
              pauseTime();
              _controller.pause();
              Navigator.pushNamed(
                context,
                GameMenu.routeName,
              ).then((value) {
                isTimeRunning = true;
                _controller.resume();
              });
            }),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Image(
                image: AssetImage('assets/images/pause.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              isTimeRunning
                  ? const Icon(
                      Icons.timelapse,
                      size: 50,
                      color: Colors.greenAccent,
                    )
                  : const Icon(
                      Icons.timelapse,
                      size: 50,
                      color: Colors.grey,
                    ),
              timer.Countdown(
                controller: _controller,
                seconds: widget.currentInterval,
                build: (_, double time) => Text(
                  time.toStringAsFixed(0),
                  style: const TextStyle(
                      fontFamily: 'Wonderbar',
                      fontSize: 40,
                      color: Colors.amber),
                ),
                interval: const Duration(seconds: 1),
                onFinished: () {
                  setState(() {
                    isTimeRunning = false;
                    widget.presentResult(context);
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Score ${widget.score}',
                style: const TextStyle(
                    color: Colors.green, fontFamily: 'Wonderbar', fontSize: 30),
              )
            ],
          )
        ],
      ),
    );
  }

  void pauseTime() {
    isTimeRunning = false;
  }
}
