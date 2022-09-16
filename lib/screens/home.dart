import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kids_math/constants/constants.dart';
import 'package:kids_math/menu/settings_menu.dart';
import 'package:kids_math/screens/levels.dart';
import 'package:kids_math/widgets/operation_button.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home-screen";
  var currentInterval = 60;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var safePadding = MediaQuery.of(context).padding.top;

    loadChromeSettings();

    void updateTime(int time) {
      setState(() {
        widget.currentInterval = time;
      });
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.pink,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  onTap: () {
                    Navigator.pushNamed(context, SettingsMenu.routeName,
                        arguments: {
                          'interval': widget.currentInterval,
                          'updateFunc': updateTime,
                        });
                  },
                  child: Image.asset(
                    "assets/images/settings.gif",
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
              ),
              Column(children: [
                SizedBox(
                  height: (size.height - safePadding) / 2,
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OperationButton(
                        icon: 'assets/images/plus.png',
                        verticalPadding: 20.0,
                        operation: Operation.Add,
                        currentInterval: widget.currentInterval,
                      ),
                      OperationButton(
                        icon: 'assets/images/minus.png',
                        verticalPadding: 20.0,
                        operation: Operation.Subtract,
                        currentInterval: widget.currentInterval,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: (size.height - safePadding) / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OperationButton(
                        icon: 'assets/images/division.png',
                        verticalPadding: 20.0,
                        operation: Operation.Divide,
                        currentInterval: widget.currentInterval,
                      ),
                      OperationButton(
                        icon: 'assets/images/multiply.png',
                        verticalPadding: 20.0,
                        operation: Operation.Multiply,
                        currentInterval: widget.currentInterval,
                      ),
                    ],
                  ),
                ),
              ]),
            ],
          )),
    );
  }

  void loadChromeSettings() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));
  }
}
