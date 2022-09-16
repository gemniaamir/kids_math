import 'package:flutter/material.dart';

class TotalTime with ChangeNotifier {
  int _time = 30;

  int get getTime {
    return _time;
  }

  void updateTime(int time) {
    _time = time;
    notifyListeners();
  }
}
