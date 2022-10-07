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

  @override
  void initState() {
    super.initState();
    _rotatingController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 10,
      ),
    );

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

  Widget _homeButtons(BuildContext _context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CapsuleButton(
            buttonText: "Start a Game",
            buttonCallback: () {
              print("received");
            },
          ),
          CapsuleButton(
            buttonText: "How to Play",
            buttonCallback: () {
              Navigator.pushNamed(_context, "instructions");
            },
          ),
          CapsuleButton(
              buttonText: "Settings",
              buttonCallback: () {
                Navigator.pushNamed(_context, "settings");
              })
        ],
      ),
    );
  }
}
