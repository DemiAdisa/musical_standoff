import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';
import 'package:musical_standoff/dependencies/color_list.dart';
import 'package:musical_standoff/dependencies/text_box.dart';
import '../dependencies/back_button.dart';
import '../models/player.dart';

class AddPlayersScreen extends StatelessWidget {
  late double? _deviceWidth;
  late double? _deviceHeight;

  final List<Player> _items = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey();

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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
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
    _items.insert(0, Player(playerName: "Item ${_items.length + 1}"));

    _key.currentState!.insertItem(
      0,
      duration: const Duration(milliseconds: 350),
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
                style: TextStyle(fontSize: 20, color: Colors.white,),
              ),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );

    _items.removeAt(index);
  }
}