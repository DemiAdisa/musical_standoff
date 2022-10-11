import 'package:flutter/material.dart';

class GameSettings with ChangeNotifier {

  //Default Number of Rounds is 10
  int _numOfRounds = 10;

  int get rounds => _numOfRounds;

  void setRounds10() {
    _numOfRounds = 10;
  }


  void setRounds15() {
    _numOfRounds = 15;
  }

  void setRounds20() {
    _numOfRounds = 20;
  }

  void setCustomRounds(int val) {
    _numOfRounds = val;
  }

  void decrementRounds() {
    _numOfRounds--;
    notifyListeners();
  }

}
