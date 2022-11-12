import 'package:flutter/material.dart';

class Player {
  late String playerName;
  int playerScore = 0;

  Player({required this.playerName});

  String get getName => playerName;

  int get getScore => playerScore;

  void incrementScore() {
    playerScore++;
  }

  void incrementScoreBy2() {
    playerScore += 2;
  }

  void incrementScoreBy3() {
    playerScore += 3;
  }

  void incrementScoreBy4() {
    playerScore += 4;
  }
}
