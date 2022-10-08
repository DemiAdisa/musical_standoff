import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/text_box.dart';
import 'package:provider/provider.dart';
import '../dependencies/back_button.dart';
import '../dependencies/color_list.dart';
import '../providers/game_settings_provider.dart';

class GameSettingsScreen extends StatefulWidget {
  GameSettingsScreen({Key? key}) : super(key: key);

  @override
  State<GameSettingsScreen> createState() => _GameSettingsScreenState();
}

class _GameSettingsScreenState extends State<GameSettingsScreen> {
  late double? _deviceWidth;

  late double? _deviceHeight;

  int selectedRadio = 10;

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
                TextBox(boxText: "GAME SETUP"),
                SizedBox(
                  height: _deviceHeight! * 0.1,
                ),
                Column(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: RadioListTile<int>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        title: const Text("Play Ten Rounds"),
                        subtitle: const Text("Game would go for 10 rounds"),
                        tileColor: ColorList().yellow(),
                        value: 10,
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = 10;
                          });

                          context.read<GameSettings>().setRounds10();
                          print(context.read<GameSettings>().rounds);
                        },
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: RadioListTile<int>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      title: const Text("Play Fifteen Rounds"),
                      subtitle: const Text("Game would go for 15 rounds"),
                      tileColor: ColorList().yellow(),
                      value: 15,
                      groupValue: selectedRadio,
                      onChanged: (value) {
                        setState(() {
                          selectedRadio = 15;
                        });

                        context.read<GameSettings>().setRounds15();
                        print(context.read<GameSettings>().rounds);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: RadioListTile<int>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      title: const Text("Play Twenty Rounds"),
                      subtitle: const Text("Game would go for 20 rounds"),
                      tileColor: ColorList().yellow(),
                      value: 20,
                      groupValue: selectedRadio,
                      onChanged: (value) {
                        setState(() {
                          selectedRadio = 20;
                        });

                        context.read<GameSettings>().setRounds20();
                        print(context.read<GameSettings>().rounds);
                      },
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
