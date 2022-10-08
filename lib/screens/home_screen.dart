import 'dart:math';

import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';

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

  //We initialize state to begin the animation of the logo
  @override
  void initState() {
    super.initState();

    _rotatingController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 10,
      ),
    );

    //Puts the rotation Animation in a Looping Manner
    _rotatingController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _imageContainer(),
            _homeButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _imageContainer() {
    return AnimatedBuilder(
      animation: _rotatingController!.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotatingController!.value * 2 * pi,
          child: child,
        );
      },
      child: SizedBox(
        width: _deviceWidth! * 0.6,
        height: _deviceHeight! * 0.6,
        child: Image.asset("assets/Logo_Files/png/logo-color-circle.png"),
      ),
    );
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
            buttonCallback: () {
              // TODO: CHeck for internet connection before pushing next screen
              Navigator.pushNamed(context, "game_settings");
            },
          ),
          const SizedBox(height: 12,),
          CapsuleButton(
            buttonText: "How to Play",
            buttonCallback: () {
              Navigator.pushNamed(context, "instructions");
            },
          ),
          const SizedBox(height: 12,),
          CapsuleButton(
              buttonText: "Settings",
              buttonCallback: () {
                Navigator.pushNamed(context, "settings");
              })
        ],
      ),
    );
  }
}
