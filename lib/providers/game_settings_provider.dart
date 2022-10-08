import 'package:flutter/material.dart';

class GameSettings with ChangeNotifier {
  int _numOfRounds = 0;

  int get rounds => _numOfRounds;

  void _setRounds10() {
    _numOfRounds = 10;
    notifyListeners();
  }

  void _setRounds15() {
    _numOfRounds = 15;
    notifyListeners();
  }

  void _setRounds20() {
    _numOfRounds = 20;
    notifyListeners();
  }

  void _decrementRounds() {
    _numOfRounds--;
    notifyListeners();
  }

}
