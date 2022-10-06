import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';
import 'package:musical_standoff/dependencies/color_list.dart';

class HomeScreen extends StatelessWidget {

  late double? _deviceWidth;
  late double? _deviceHeight;

  HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorList().getColor1(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _imageContainer(),
              _homeButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageContainer() {
    return SizedBox(
      width: _deviceWidth! * 0.6,
      height: _deviceHeight! * 0.6,
      child: Image.asset("assets/Logo_Files/png/logo-color-circle.png"),
    );
  }

  Widget _homeButtons() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          CapsuleButton(
              buttonText: "Start a Game",
              buttonCallback: () {
                print("received");
              }),
          CapsuleButton(
              buttonText: "Start a Game2",
              buttonCallback: () {
                print("received2");
              })
        ],
      ),
    );
  }
}
