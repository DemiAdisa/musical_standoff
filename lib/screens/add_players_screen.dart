import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';
import 'package:musical_standoff/dependencies/color_list.dart';
import 'package:musical_standoff/dependencies/text_box.dart';
import 'package:musical_standoff/providers/add_players_provider.dart';
import 'package:provider/provider.dart';
import '../dependencies/back_button.dart';
import '../models/player.dart';

class AddPlayersScreen extends StatefulWidget {
  AddPlayersScreen({Key? key}) : super(key: key);

  @override
  State<AddPlayersScreen> createState() => _AddPlayersScreenState();
}

class _AddPlayersScreenState extends State<AddPlayersScreen> {
  late double? _deviceWidth;

  late double? _deviceHeight;

  final List<Player> _items = [];

  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //Prevent Dialog from Causing Overflow Error
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
                  height: _deviceHeight! * 0.07,
                ),
                // IconButton(
                //   iconSize: 35.0,
                //   highlightColor: ColorList().yellow(),
                //   onPressed: () {},
                //   color: ColorList().yellow(),
                //   icon: const Icon(Icons.add_circle_outline),
                // ),
                Container(
                  height: _deviceHeight! * 1.1,
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Scrollbar(
                    trackVisibility: true,
                    thumbVisibility: true,
                    child: AnimatedList(
                      key: _key,
                      initialItemCount: 0,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index, animation) {
                        return SizeTransition(
                          key: UniqueKey(),
                          sizeFactor: animation,
                          child: Card(
                            margin: const EdgeInsets.all(10.0),
                            color: ColorList().yellow(),
                            child: ListTile(
                              title: Text(
                                _items[index].playerName,
                                style: const TextStyle(fontSize: 20),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  removeFromList(index);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                _bottomButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CapsuleButton(
            buttonText: "Add Player",
            buttonCallback: () {
              if (_items.length < 10) {
                TextEditingController pName = TextEditingController();
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Players Name?"),
                          content: TextField(
                            controller: pName,
                            decoration: const InputDecoration(
                              hintText: "Input Players Name",
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (!(pName.text == "")) {
                                    addToList(pName.text);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text("SUBMIT"))
                          ],
                        ));
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Row(
                      children: const [
                        Icon(Icons.error),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Max Number of Players!")
                      ],
                    ),
                    content: const Text(
                        "You have added the maximum number of permitted players."),
                  ),
                );
              }
            }),
        const SizedBox(
          width: 50,
        ),
        CapsuleButton(
            buttonText: "Start Game",
            buttonCallback: () {
              if (_items.isNotEmpty) {
                context.read<AddPlayers>().fillList(_items);

                //Make sure user does not want to add more players
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Row(
                      children: const [
                        Icon(Icons.crisis_alert),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Confirm Selection")
                      ],
                    ),
                    content: const Text(
                        "Game Settings and Players cannot be edited after."),
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
                        onPressed: () {},
                        child: const Text('ACCEPT'),
                      ),
                    ],
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Row(
                      children: const [
                        Icon(Icons.error),
                        SizedBox(
                          width: 10,
                        ),
                        Text("No Players Added")
                      ],
                    ),
                    content: const Text(
                        "No players detected. Sorry you need friends to play 😁"),
                  ),
                );
              }
            })
      ],
    );
  }

  void addToList(String playerName) {
    _items.insert(0, Player(playerName: playerName));

    _key.currentState!.insertItem(
      0,
      duration: const Duration(milliseconds: 300),
    );
  }

  void removeFromList(int index) {
    _key.currentState!.removeItem(
      index,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: const Card(
            margin: EdgeInsets.all(10),
            color: Colors.red,
            child: ListTile(
              title: Text(
                "Removed",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 200),
    );

    _items.removeAt(index);
  }
}
