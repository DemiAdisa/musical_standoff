import 'package:flutter/material.dart';

/// This is a provider class to handle the Game Session Settings (Rounds etc.)
class GameSettings with ChangeNotifier {

  //Default Number of Rounds is 10
  int _numOfRounds = 10;

  //For Display
  int _displayRound = 0;

  //Rounds start from 1
  int _startingRound = 1;

  int get rounds => _numOfRounds;
  int get startRound => _startingRound;
  int get displayRound => _displayRound;

  void setRounds10() {
    _numOfRounds = 10;
    _displayRound = 10;
  }


  void setRounds15() {
    _numOfRounds = 15;
    _displayRound = 15;
  }

  void setRounds20() {
    _numOfRounds = 20;
    _displayRound = 20;
  }

  void setCustomRounds(int val) {
    _numOfRounds = val;
  }

  void resetRounds() {
    _numOfRounds = 10;
    _startingRound = 1;
    _displayRound = 0;
  }

  void advanceRounds() {
    _startingRound++;
    _numOfRounds--;

    notifyListeners();
  }

}
