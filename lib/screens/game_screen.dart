import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';
import 'package:musical_standoff/dependencies/f_card.dart';
import 'package:musical_standoff/providers/add_players_provider.dart';
import 'package:provider/provider.dart';

import '../dependencies/color_list.dart';
import '../models/player.dart';

class Game extends StatefulWidget {
  Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late double? _deviceWidth;
  late double? _deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _genreBox(),
                _roundBox(),
                _filterWheel(),
                _playerWheel(),
                _buttonRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _genreBox() {
    return Container(
      padding: EdgeInsets.all(_deviceWidth! * 0.03),
      decoration: BoxDecoration(
        color: ColorList().yellow(),
        boxShadow: const [
          BoxShadow(blurRadius: 15.0),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(
        "GENRE",
        style: TextStyle(fontSize: 30.0),
      ),
    );
  }

  Widget _roundBox() {
    return Text(
      "Round 1",
      style: TextStyle(
        fontSize: 25,
        color: Colors.transparent,
        shadows: const [Shadow(offset: Offset(0, -5), color: Colors.white)],
        decoration: TextDecoration.underline,
        decorationThickness: 3,
        decorationColor: ColorList().yellow(),
      ),
    );
  }

  Widget _filterWheel() {
    return SizedBox(
      height: _deviceHeight! * 0.45,
      child: Column(
        children: [
          const Center(
            child: Text(
              "Tap to Reveal Filter",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FCard(difficultyLvl: 1, backValue: "1ss"),
                  const SizedBox(
                    width: 20,
                  ),
                  FCard(difficultyLvl: 2, backValue: "2ss"),
                  const SizedBox(
                    width: 20,
                  ),
                  FCard(difficultyLvl: 3, backValue: "3ss"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _playerWheel() {
    return SizedBox(
      height: _deviceHeight! * 0.45,
      child: Column(
        children: [
          const Center(
            child: Text(
              "Player Leaderboard",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _playerObjToCard(
                    context.read<AddPlayers>().getListOfPlayers()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CapsuleButton(
          buttonText: "Show Description",
          buttonCallback: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Genre Description"),
                content: Text(
                  "Description Here",
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      //Launch Youtube
                    },
                    child: const Text('See Example'),
                  ),
                ],
              ),
            );
          },
        ),
        CapsuleButton(buttonText: "Next Round", buttonCallback: () {}),
      ],
    );
  }

  List<Widget> _playerObjToCard(List<Player> playerList) {
    List<Widget> convertedList = [];

    for (Player p in playerList) {
      convertedList.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: FlipCard(
          fill: Fill.fillBack,
          // Fill the back side of the card to make in the same size as the front.
          direction: FlipDirection.HORIZONTAL,
          // default
          front: Container(
            width: _deviceWidth! * 0.5,
            height: _deviceHeight! * 0.35,
            decoration: BoxDecoration(
              color: ColorList().yellow(),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Center(child: Text(p.getName)),
          ),
          back: Container(
            decoration: BoxDecoration(
              color: ColorList().yellow(),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child:
                Center(child: Text("You currently have ${p.getScore} points")),
          ),
        ),
      ));
    }

    return convertedList;
  }
}
