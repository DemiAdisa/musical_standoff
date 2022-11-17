import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:musical_standoff/dependencies/color_list.dart';
import 'package:musical_standoff/screens/leaderboard.dart';
import 'package:musical_standoff/screens/settings_screen.dart';
import 'package:musical_standoff/screens/user_profile.dart';

import '../screens/home_screen.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {

  final myTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 18
  );

  List<ScreenHiddenDrawer> pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pages = [
      ScreenHiddenDrawer(ItemHiddenMenu(
        name: "Home",
        baseStyle: myTextStyle,
        selectedStyle: myTextStyle,
      ), HomeScreen()),
      ScreenHiddenDrawer(ItemHiddenMenu(
        name: "Leaderboard",
        baseStyle: myTextStyle,
        selectedStyle: myTextStyle,
      ), LeaderboardScreen()),
      ScreenHiddenDrawer(ItemHiddenMenu(
        name: "Settings",
        baseStyle: myTextStyle,
        selectedStyle: myTextStyle,
      ), SettingsScreen()),
      ScreenHiddenDrawer(ItemHiddenMenu(
        name: "Profile",
        baseStyle: myTextStyle,
        selectedStyle: myTextStyle,
      ), UserProfileScreen()),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: ColorList().spaceCadet(),
      initPositionSelected: 0,
      withAutoTittleName: false,
      backgroundColorAppBar: ColorList().midnight(),
      elevationAppBar: 0,
      slidePercent: 50,
      screens: pages,
    );
  }
}
