import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:musical_standoff/providers/add_players_provider.dart';
import 'package:musical_standoff/providers/game_settings_provider.dart';
import 'package:musical_standoff/providers/gameplay_provider.dart';
import 'package:musical_standoff/screens/add_players_screen.dart';
import 'package:musical_standoff/screens/game_mode.dart';
import 'package:musical_standoff/screens/game_screen.dart';
import 'package:musical_standoff/screens/game_settings.dart';
import 'package:musical_standoff/screens/home_screen.dart';
import 'package:musical_standoff/screens/instructions.dart';
import 'package:musical_standoff/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:musical_standoff/dependencies/color_list.dart';

import 'dependencies/hidden_drawer.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameSettings()),
        ChangeNotifierProvider(create: (_) => AddPlayers()),
        ChangeNotifierProvider(create: (_) => Gameplay()),

      ],
      child: const MyApp(),
    ),
  );
}


//Application Entry-point
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Musical Standoff',
        theme: ThemeData(
          scaffoldBackgroundColor: ColorList().midnight(),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => HiddenDrawer(),
          "settings": (context) => SettingsScreen(),
          "instructions": (context) => InstructionsScreen(),
          "game_modes": (context) => GameModeScreen(),
          "game_settings": (context) => GameSettingsScreen(),
          "adding_players": (context) => AddPlayersScreen(),
          "game": (context) => Game(),

        });
  }
}
