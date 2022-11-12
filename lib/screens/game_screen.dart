import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';
import 'package:musical_standoff/dependencies/f_card.dart';
import 'package:musical_standoff/providers/add_players_provider.dart';
import 'package:musical_standoff/providers/game_settings_provider.dart';
import 'package:musical_standoff/providers/gameplay_provider.dart';
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
  late Future<void> dataFuture;
  final _playerScrollController = ScrollController();

  //For the radio in the Point awarding dialog
  String _roundWinnersName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataFuture = context.read<Gameplay>().getGameplayData();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: FutureBuilder<void>(
              future: dataFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: ColorList().yellow(),
                          )
                        ],
                      ),
                    );
                  case ConnectionState.done:
                  default:
                    return Center(
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
                    );
                }
              }),
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
        context.watch<Gameplay>().genreName,
        style: const TextStyle(fontSize: 28.0),
      ),
    );
  }

  Widget _roundBox() {
    return Text(
      "Round ${context.watch<GameSettings>().startRound}/${context.watch<GameSettings>().displayRound}",
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
                  FCard(
                    difficultyLvl: 1,
                    backValue: context.watch<Gameplay>().getEasyFilter(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FCard(
                    difficultyLvl: 2,
                    backValue: context.watch<Gameplay>().getMediumFilter(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FCard(
                    difficultyLvl: 3,
                    backValue: context.watch<Gameplay>().getHardFilter(),
                  ),
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
              controller: _playerScrollController,
              thumbVisibility: true,
              child: ListView(
                controller: _playerScrollController,
                scrollDirection: Axis.horizontal,
                children: _playerObjToCard(
                    context.watch<AddPlayers>().getListOfPlayers()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    context.read<AddPlayers>().resetList();
    context.read<GameSettings>().resetRounds();
    Navigator.pushNamed(context, "/");
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
                  context.watch<Gameplay>().genreDesc,
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
        CapsuleButton(
          buttonText: context.watch<GameSettings>().checkRounds()
              ? "Finish Game"
              : "Next Round",
          buttonCallback: () {
            //Check if Rounds have been elapsed
            bool isRoundsFinished = context.read<GameSettings>().checkRounds();

            //Rounds not finished
            if (!isRoundsFinished) {
              _updateScores();
            } else {
              //Rounds have finished
              _finishGame();
            }
          },
        ),
        CapsuleButton(
          buttonText: "End Game",
          buttonCallback: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Row(
                  children: const [
                    Icon(Icons.crisis_alert),
                    SizedBox(
                      width: 10,
                    ),
                    Text("End Game?")
                  ],
                ),
                content: const Text(
                    "You will lose all your current selections and progress."),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('CANCEL'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      _resetGame();
                    },
                    child: const Text('END GAME'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _updateScores() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
          title: Row(
            children: const [
              Icon(Icons.accessibility_new_outlined),
              SizedBox(
                width: 10,
              ),
              Text("Who won this Round?")
            ],
          ),
          children: [
            _playerObjToTiles(
                playerList: context.read<AddPlayers>().getListOfPlayers(),
                isGameOver: false),
          ]),
    );
  }

  void _finishGame() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
          title: Row(
            children: const [
              Icon(Icons.accessibility_new_outlined),
              SizedBox(
                width: 10,
              ),
              Text("The Final Round!")
            ],
          ),
          children: [
            _playerObjToTiles(
                playerList: context.read<AddPlayers>().getListOfPlayers(),
                isGameOver: true),
          ]),
    );
  }

  Widget _playerObjToTiles(
      {required List<Player> playerList, required bool isGameOver}) {
    List<Widget> tileList = [];
    final scrollController = ScrollController();

    for (Player p in playerList) {
      tileList.add(
        CapsuleButton(
            buttonText: p.playerName,
            buttonCallback: () {
              _roundWinnersName = p.playerName;

              _filterDialogBox(
                  winnersName: _roundWinnersName, gameOver: isGameOver);
            }),
      );
    }

    return Container(
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        height: 250,
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              controller: scrollController,
              children: tileList,
            ),
          ),
        ));
  }

  void _filterDialogBox({required String winnersName, required bool gameOver}) {
    final filterScrollController = ScrollController();
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("What Filter Was Used?"),
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              width: double.maxFinite,
              height: 250,
              child: Scrollbar(
                controller: filterScrollController,
                thumbVisibility: true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    controller: filterScrollController,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        onPressed: () {
                          if (!gameOver) {
                            context.read<AddPlayers>().updatePlayerScore(
                                pName: winnersName, filterType: 0);

                            // Remove prior Pop up boxes
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            //Advance to next round
                            context.read<GameSettings>().advanceRounds();
                            setState(() {
                              dataFuture =
                                  context.read<Gameplay>().getGameplayData();
                            });
                          } else {
                            context.read<AddPlayers>().updatePlayerScore(
                                pName: winnersName, filterType: 0);

                            // Remove prior Pop up boxes
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            _showWinner();
                          }
                        },
                        child: const Text("No Filter"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          if (!gameOver) {
                            context.read<AddPlayers>().updatePlayerScore(
                                pName: winnersName, filterType: 1);

                            // Remove prior Pop up boxes
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            //Advance to next round
                            context.read<GameSettings>().advanceRounds();
                            setState(() {
                              dataFuture =
                                  context.read<Gameplay>().getGameplayData();
                            });
                          } else {
                            context.read<AddPlayers>().updatePlayerScore(
                                pName: winnersName, filterType: 1);

                            // Remove prior Pop up boxes
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            _showWinner();
                          }
                        },
                        child: const Text("Easy"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () {
                          if (!gameOver) {
                            context.read<AddPlayers>().updatePlayerScore(
                                pName: winnersName, filterType: 2);

                            // Remove prior Pop up boxes
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            //Advance to next round
                            context.read<GameSettings>().advanceRounds();
                            setState(() {
                              dataFuture =
                                  context.read<Gameplay>().getGameplayData();
                            });
                          } else {
                            context.read<AddPlayers>().updatePlayerScore(
                                pName: winnersName, filterType: 2);

                            // Remove prior Pop up boxes
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            _showWinner();
                          }
                        },
                        child: const Text("Medium"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          if (!gameOver) {
                            context.read<AddPlayers>().updatePlayerScore(
                                pName: winnersName, filterType: 3);

                            // Remove prior Pop up boxes
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            //Advance to next round
                            context.read<GameSettings>().advanceRounds();
                            setState(() {
                              dataFuture =
                                  context.read<Gameplay>().getGameplayData();
                            });
                          } else {
                            context.read<AddPlayers>().updatePlayerScore(
                                pName: winnersName, filterType: 3);

                            // Remove prior Pop up boxes
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            _showWinner();
                          }
                        },
                        child: const Text("Hard"),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void _showWinner() {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Congratulations, You finished the game!"),
              content: SizedBox(
                height: 175,
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text("The Winner Is:"),
                  ),
                  FlipCard(
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
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              context.read<AddPlayers>().getWinner().playerName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Tap to Reveal Player's Score",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    back: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: ColorList().yellow(),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        "${context.read<AddPlayers>().getWinner().playerName} won "
                        "with ${context.read<AddPlayers>().getWinner().getScore} points",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      )),
                    ),
                  ),
                ]),
              ),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _resetGame();
                    },
                    child: const Text("OK!"))
              ],
            ));
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    p.getName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Tap to Reveal Player's Score",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          back: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: ColorList().yellow(),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Center(
                child: Text(
              "${p.getName} currently has ${p.getScore} points",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            )),
          ),
        ),
      ));
    }

    return convertedList;
  }
}
