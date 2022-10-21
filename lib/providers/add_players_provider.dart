import 'package:flutter/material.dart';

import '../models/player.dart';

///This is a provider class to handle Player Data
class AddPlayers with ChangeNotifier {


  List<Player> _listOfPlayers = [];

  void addPlayer(Player pObj) {
    _listOfPlayers.add(pObj);
    notifyListeners();
  }

  void fillList(List<Player> pObjList) {
    _listOfPlayers = pObjList;
  }

  void removePlayer(Player playerObj){
    _listOfPlayers.remove(playerObj);
    notifyListeners();
  }

  void resetList()
  {
    _listOfPlayers = [];
    notifyListeners();
  }

  List<Player> getListOfPlayers() {
    return _listOfPlayers;
  }
}