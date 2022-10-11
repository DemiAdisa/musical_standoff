import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';
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

  late int selectedRadio;
  bool selectCustomRounds = false;

  TextEditingController customRoundText = TextEditingController();

  @override
  void initState() {
    super.initState();

    selectedRadio = 10;
    context.read<GameSettings>().setRounds10();

  }

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
                Expanded(
                  child: Container(
                    // TODO: Figure out how to use clip behaviour in Container
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RadioListTile<int>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              title: const Text("Play Ten Rounds"),
                              subtitle:
                                  const Text("Game would go for 10 rounds"),
                              tileColor: ColorList().yellow(),
                              value: 10,
                              groupValue: selectedRadio,
                              onChanged: (value) {
                                setState(() {
                                  selectedRadio = 10;

                                  if (selectCustomRounds) {
                                    selectCustomRounds = !selectCustomRounds;
                                  }

                                });

                                context.read<GameSettings>().setRounds10();
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RadioListTile<int>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              title: const Text("Play Fifteen Rounds"),
                              subtitle:
                                  const Text("Game would go for 15 rounds"),
                              tileColor: ColorList().yellow(),
                              value: 15,
                              groupValue: selectedRadio,
                              onChanged: (value) {
                                setState(() {
                                  selectedRadio = 15;

                                  if (selectCustomRounds) {
                                    selectCustomRounds = !selectCustomRounds;
                                  }
                                });

                                context.read<GameSettings>().setRounds15();
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RadioListTile<int>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              title: const Text("Play Twenty Rounds"),
                              subtitle:
                                  const Text("Game would go for 20 rounds"),
                              tileColor: ColorList().yellow(),
                              value: 20,
                              groupValue: selectedRadio,
                              onChanged: (value) {
                                setState(() {
                                  selectedRadio = 20;

                                  if (selectCustomRounds) {
                                    selectCustomRounds = !selectCustomRounds;
                                  }
                                });

                                context.read<GameSettings>().setRounds20();
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SwitchListTile.adaptive(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              value: selectCustomRounds,
                              onChanged: (valueVar) {
                                selectedRadio = selectedRadio == 0
                                    ? (selectedRadio = 10)
                                    : selectedRadio = 0;

                                setState(() {
                                  selectCustomRounds = !selectCustomRounds;
                                });

                                if (!selectCustomRounds) {
                                  context.read<GameSettings>().setRounds10();
                                }
                              },
                              tileColor: ColorList().yellow(),
                              title: const Text("Set Custom Rounds"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Visibility(
                              visible: selectCustomRounds,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 100,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20.0),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: customRoundText,
                                    onSubmitted: (numValue) {
                                      context
                                          .read<GameSettings>()
                                          .setCustomRounds(int.parse(numValue));
                                    },
                                    onChanged: (numValue) {
                                      context
                                          .read<GameSettings>()
                                          .setCustomRounds(int.parse(numValue));
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: ColorList().yellow(),
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20.0)),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CapsuleButton(
                                buttonText: "Next",
                                buttonCallback: () {
                                  print("Selected Radio: $selectedRadio");
                                  print(context.read<GameSettings>().rounds);
                                }),
                          ]),
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
}
