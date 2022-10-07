import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';

class HomeScreen extends StatelessWidget {
  late double? _deviceWidth;
  late double? _deviceHeight;

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _imageContainer(),
              _homeButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageContainer() {
    return Center(
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
              print("received");
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
