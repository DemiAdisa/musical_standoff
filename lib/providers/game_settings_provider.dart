import 'package:flutter/material.dart';

class GameSettings with ChangeNotifier {
  int _numOfRounds = 0;

  int get rounds => _numOfRounds;

  void setRounds10() {
    _numOfRounds = 10;
    notifyListeners();
  }


  void setRounds15() {
    _numOfRounds = 15;
    notifyListeners();
  }

  void setRounds20() {
    _numOfRounds = 20;
    notifyListeners();
  }

  void setCustomRounds(int val) {
    _numOfRounds = val;
    notifyListeners();
  }

  void decrementRounds() {
    _numOfRounds--;
    notifyListeners();
  }

}
