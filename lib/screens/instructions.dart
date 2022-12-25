import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/custom_tile.dart';
import 'package:musical_standoff/dependencies/regular_back_button.dart';
import 'package:musical_standoff/dependencies/text_box.dart';
import '../dependencies/custom_back_button.dart';

class InstructionsScreen extends StatelessWidget {
  late double? _deviceWidth;
  late double? _deviceHeight;

  InstructionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollCntl = ScrollController();
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: RegularBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: _deviceHeight! * 0.17),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                      width: _deviceWidth! * 0.5,
                      height: _deviceHeight! * 0.5,
                      child: Image.asset(
                          "assets/Logo_Files/png/logo-color-circle.png")),
                  SizedBox(
                    height: _deviceHeight! * 0.1,
                  ),
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: scrollCntl,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        controller: scrollCntl,
                        children: [
                          RichText(
                              overflow: TextOverflow.clip,
                              text: const TextSpan(
                                  text: "Welcome to Musical Standoff! ",
                                  style: TextStyle(fontSize: 20),
                                  children: [
                                    TextSpan(
                                      text:
                                          "A game where anyone can test their musical "
                                          "knowledge and see how well they fair against "
                                          "other musically savvy individuals.\n\n ",
                                    ),
                                    TextSpan(
                                        text:
                                            "There are a couple different game modes"
                                            " available for you to play. To learn how any "
                                            "of these modes are played, please click the corresponding button below"),
                                  ])),
                          SizedBox(
                            height: _deviceHeight! * 0.05,
                          ),
                          CustomTile(
                            mainText: "Single Player",
                            subText:
                                "Challenge yourself and see how well you can "
                                "do in a game against no one but you",
                            callback: () {
                              debugPrint("Clicked");
                            },
                          ),
                          SizedBox(
                            height: _deviceHeight! * 0.05,
                          ),
                          CustomTile(
                            mainText: "Ranked",
                            subText:
                                "Test your mettle against players from all over "
                                "the world",
                            callback: () {
                              debugPrint("Clicked");
                            },
                          ),
                          SizedBox(
                            height: _deviceHeight! * 0.05,
                          ),
                          CustomTile(
                            mainText: "Multiplayer",
                            subText:
                                "Challenge your friends and see who is the better player",
                            callback: () {
                              debugPrint("Clicked");
                            },
                          ),
                          SizedBox(
                            height: _deviceHeight! * 0.05,
                          ),
                          CustomTile(
                            mainText: "Group Play",
                            subText:
                                "Have a group and not everyone has the app? "
                                "Group Play can help with that",
                            callback: () {
                              debugPrint("Clicked");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
