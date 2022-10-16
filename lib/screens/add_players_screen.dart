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
  late List<Player> items;

  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    items = context.read<AddPlayers>().listOfPlayers;

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
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  child: ListWheelScrollView(
                    itemExtent: 250,
                    children: _turnListToCards(items),
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

  Widget _placeHolderCard(String textVal) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      color: ColorList().yellow(),
      child: ListTile(
        title: Text(
          textVal,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  List<Widget> _turnListToCards(List<Player> localItems) {
    List<Widget> convertedList = [];

    if (localItems.isEmpty) {
      return [
        _placeHolderCard("No Players Added Yet"),
        _placeHolderCard("Please Click Add Player Button"),
        _placeHolderCard("To add the players"),
        _placeHolderCard("for this Game Session")
      ];
    }else {
      for (int i = 0; i < localItems.length; i++) {
        convertedList.add(
          Card(
            margin: const EdgeInsets.all(10.0),
            color: ColorList().yellow(),
            child: ListTile(
              title: Text(
                localItems[i].playerName,
                style: const TextStyle(fontSize: 20),
              ),
              trailing: IconButton(
                onPressed: () {
                  removeFromList(items[i]);
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          ),
        );
      }

      return convertedList;
    }


  }

  Widget _bottomButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CapsuleButton(
            buttonText: "Add Player",
            buttonCallback: () {
              addToList();
            }),
        const SizedBox(
          width: 50,
        ),
        CapsuleButton(buttonText: "Start Game", buttonCallback: () {})
      ],
    );
  }

  void addToList() {
    context.read<AddPlayers>().addPlayer(Player(playerName: "Item ${items.length + 1}"));
    print(items);
  }

  void removeFromList(Player obj) {
    context.read<AddPlayers>().removePlayer(obj);
  }
}
