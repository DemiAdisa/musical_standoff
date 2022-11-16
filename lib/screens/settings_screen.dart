import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/custom_back_button.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';
import 'package:musical_standoff/dependencies/text_box.dart';

import '../dependencies/color_list.dart';
import '../dependencies/regular_back_button.dart';

class SettingsScreen extends StatefulWidget {

  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late double? _deviceWidth;

  late double? _deviceHeight;

  bool bgm = true;

  bool sfx = true;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      // floatingActionButton: RegularBackButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: _deviceHeight! * 0.17),
            child: Column(
              children: [
                // TextBox(boxText: "SETTINGS"),
                // SizedBox(
                //   height: _deviceHeight! * 0.45,
                // ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SwitchListTile.adaptive(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        value: bgm,
                        onChanged: (value) {
                          setState(() {
                            bgm = !bgm;
                          });
                        },
                        tileColor: ColorList().yellow(),
                        title: const Text("Background Music"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SwitchListTile.adaptive(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        value: sfx,
                        onChanged: (value) {
                          setState(() {
                            sfx = !sfx;
                          });
                        },
                        tileColor: ColorList().yellow(),
                        title: const Text("Sound Effects"),
                      ),
                    ],
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
