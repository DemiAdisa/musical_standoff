import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';
import 'package:musical_standoff/dependencies/text_box.dart';
import 'package:musical_standoff/dependencies/underline_text.dart';

import '../dependencies/color_list.dart';
import '../dependencies/regular_back_button.dart';

class GameModeScreen extends StatefulWidget {
  const GameModeScreen({Key? key}) : super(key: key);

  @override
  State<GameModeScreen> createState() => _GameModeScreenState();
}

class _GameModeScreenState extends State<GameModeScreen> {
  late double? _deviceWidth;
  late double? _deviceHeight;
  final _scrollCtrl = ScrollController();

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
                TextBox(boxText: "Game Modes"),
                SizedBox(
                  height: _deviceHeight! * 0.07,
                ),
                UnderlineText(
                  txtContent: "Choose Game Mode",
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _singlePlayerMode(),
                        _rankedPlayerMode(),
                        _multiplayerMode(),
                        _groupPlayMode(),
                        const Text(
                          "Don't know how to play any mode?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        CapsuleButton(
                            buttonText: "Read Tutorials",
                            buttonCallback: () {
                              Navigator.of(context).pushNamed("instructions");
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _singlePlayerMode() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: ColorList().yellow(),
      ),
      child: ListTile(
        title: const Text("Single Player"),
        subtitle: const Text("Challenge yourself and see how well you can "
            "do in a game against no one but you"),
        trailing: const Icon(Icons.arrow_circle_right_outlined),
        onTap: () {
          _snackBarPopUp(context);
        },
      ),
    );
  }

  Widget _rankedPlayerMode() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: ColorList().yellow(),
      ),
      child: ListTile(
        title: const Text("Ranked"),
        subtitle: const Text(
            "Test your mettle against players from all over the world"),
        trailing: const Icon(Icons.arrow_circle_right_outlined),
        onTap: () {
          _snackBarPopUp(context);
        },
      ),
    );
  }

  Widget _groupPlayMode() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: ColorList().yellow(),
      ),
      child: ListTile(
        title: const Text("Group Play"),
        subtitle: const Text("Have a group and not everyone has the app? "
            "Group Play can help with that"),
        trailing: const Icon(Icons.arrow_circle_right_outlined),
        onTap: () {
          Navigator.of(context).pushNamed("game_settings");
        },
      ),
    );
  }

  Widget _multiplayerMode() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: ColorList().yellow(),
      ),
      child: ListTile(
        title: const Text("Multiplayer"),
        subtitle: const Text(
            "Challenge your friends and see who is the better player"),
        trailing: const Icon(Icons.arrow_circle_right_outlined),
        onTap: () {
          _snackBarPopUp(context);
        },
      ),
    );
  }
}

void _snackBarPopUp(BuildContext context) {
  final snackBar = SnackBar(
    content: Row(
      children: const [
        Icon(Icons.error_outline),
        SizedBox(
          width: 10,
        ),
        Text('Game Mode Coming Soon'),
      ],
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
