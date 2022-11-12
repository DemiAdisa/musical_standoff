import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/regular_back_button.dart';
import 'package:musical_standoff/dependencies/text_box.dart';
import '../dependencies/custom_back_button.dart';

class InstructionsScreen extends StatelessWidget {

  late double? _deviceWidth;
  late double? _deviceHeight;

  InstructionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: RegularBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: _deviceHeight! * 0.17),
            child: Column(
              children: [
                TextBox(boxText: "HOW TO PLAY"),
                SizedBox(
                  height: _deviceHeight! * 0.2,
                ),
              Container(
                child: const SingleChildScrollView(
                ),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
