import 'package:flutter/material.dart';
import 'package:musical_standoff/screens/home_screen.dart';
import 'package:musical_standoff/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:musical_standoff/dependencies/color_list.dart';

void main() {
  // runApp(
  //   MultiProvider(
  //     providers: const [],
  //     child: const MyApp(),
  //   ),
  // );

  runApp(
    const MyApp(),
  );
}

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
        initialRoute: "/",
        routes: {
          "/": (context) => HomeScreen(),
          "settings": (context) => SettingsScreen(),
        });
  }
}
