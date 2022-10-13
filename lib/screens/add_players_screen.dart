import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';
import 'package:musical_standoff/dependencies/color_list.dart';
import 'package:musical_standoff/dependencies/text_box.dart';
import '../dependencies/back_button.dart';

class AddPlayersScreen extends StatelessWidget {
  late double? _deviceWidth;
  late double? _deviceHeight;

  AddPlayersScreen({Key? key}) : super(key: key);

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
                TextBox(boxText: "Add Players"),
                SizedBox(
                  height: _deviceHeight! * 0.03,
                ),
                IconButton(
                  iconSize: 35.0,
                  highlightColor: ColorList().yellow(),
                  onPressed: () {},
                  color: ColorList().yellow(),
                  icon: const Icon(Icons.add_circle_outline),
                ),
                SizedBox(
                  height: _deviceHeight! * 0.1,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: SingleChildScrollView(
                    child: Container(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
