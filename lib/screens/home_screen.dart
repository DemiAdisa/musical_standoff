import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/color_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      width: 250,
      height: 250,
      child: Image.asset("assets/Logo_Files/png/logo-color-circle.png"),
    );
  }

  Widget _homeButtons() {
    return Column(
      children: [
        ElevatedButton(onPressed: () {}, child: const Text("Start a Game")),
        ElevatedButton(onPressed: () {}, child: const Text("Start a Game")),
        ElevatedButton(onPressed: () {}, child: const Text("Start a Game")),
      ],
    );
  }
}
