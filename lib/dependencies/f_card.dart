import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class FCard extends StatelessWidget {
  final int difficultyLvl;
  final String backValue;

  late double? _deviceWidth;
  late double? _deviceHeight;

  FCard({
    required this.difficultyLvl,
    required this.backValue,
  });

  @override
  Widget build(BuildContext context) {
    //Get the Width and Height of the Device
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return FlipCard(
      fill: Fill.fillBack,
      // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL,
      // default
      front: Container(
        width: _deviceWidth! * 0.35,
        height: _deviceHeight! * 0.35,
        decoration: BoxDecoration(
          color: determineColor(determineDifficulty(difficultyLvl)),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Center(
            child: Text(
          determineDifficulty(difficultyLvl),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            color: Colors.white,
          ),
        )),
      ),
      back: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: determineColor(determineDifficulty(difficultyLvl)),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Center(
            child: Text(
          backValue,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        )),
      ),
    );
  }

  Color determineColor(String diff) {
    if (diff == "EASY") {
      return Colors.green;
    } else if (diff == "MEDIUM") {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String determineDifficulty(int type) {
    if (type == 1) {
      return "EASY";
    } else if (type == 2) {
      return "MEDIUM";
    } else {
      return "HARD";
    }
  }
}
