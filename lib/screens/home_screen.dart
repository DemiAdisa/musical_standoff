import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';


///This is the home screen
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late double? _deviceWidth;
  late double? _deviceHeight;

  AnimationController? _rotatingController;

  final Connectivity _connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _animatedHead(),
              _homeButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _animatedHead() {
    return Lottie.asset("assets/animations/listening-to-music.json");
  }

  Widget _homeButtons(BuildContext context) {
    // TODO: MainAxisAlignment.spaceEvenly is not functioning properly, fix
    //Using SizedBox in the meantime
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CapsuleButton(
            buttonText: "Start a Game",
            buttonCallback: () async {
              ConnectivityResult connectivityResult =
                  await _connectivity.checkConnectivity();

              if (connectivityResult == ConnectivityResult.mobile ||
                  connectivityResult == ConnectivityResult.wifi) {
                // TODO: See TODO 1
                Navigator.pushNamed(context, "game_modes");
              } else if (connectivityResult == ConnectivityResult.none) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Row(
                      children: const [
                        Icon(Icons.error),
                        SizedBox(width: 10,),
                        Text("Internet Required")
                      ],
                    ),
                    content: const Text(
                        "An internet connection is required to play this game. "
                        "Please connect to the internet and try again"),
                  ),
                );
                //   title:
                // ));
              }
              // TODO 1: Review Futures and Fix the Linting Error
            },
          ),
          CapsuleButton(
            buttonText: "How to Play",
            buttonCallback: () {
              Navigator.pushNamed(context, "instructions");
            },
          ),
          CapsuleButton(
              buttonText: "Settings",
              buttonCallback: () {
                Navigator.pushNamed(context, "settings");
              })
        ],
      ),
    );
  }

// Future<Bool> checkForInternet() async{
//   ConnectivityResult connectivityResult =
//       await _connectivity.checkConnectivity();
//
//   Future<bool> isTrue = true as Future<bool>;
//
//   if (connectivityResult == ConnectivityResult.mobile ||
//       connectivityResult == ConnectivityResult.wifi) {
//     return ;
//   } else if (connectivityResult == ConnectivityResult.none) {
//     print("No connection");
//   }
// }
}
