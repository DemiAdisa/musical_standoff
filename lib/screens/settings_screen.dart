import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/back_button.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';
import 'package:musical_standoff/dependencies/text_box.dart';

class SettingsScreen extends StatelessWidget {
  late double? _deviceWidth;
  late double? _deviceHeight;

  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: CustomBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: _deviceHeight! * 0.17),
            child: Column(
              children: [
                TextBox(boxText: "SETTINGS"),
                SizedBox(
                  height: _deviceHeight! * 0.5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CapsuleButton(buttonText: "Background Music Toggle", buttonCallback: () {}),
                    CapsuleButton(buttonText: "Effects Toggle", buttonCallback: () {}),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
