import 'package:flutter/material.dart';

import '../models/player.dart';

class AddPlayers with ChangeNotifier {


  List<Player> listOfPlayers = [];

  void addPlayer(Player pObj) {
    listOfPlayers.add(pObj);
    notifyListeners();
  }

  void removePlayer(Player playerObj){
    listOfPlayers.remove(playerObj);
    notifyListeners();
  }

  void resetList()
  {
    listOfPlayers = [];
    notifyListeners();
  }

  List<Player> getListOfPlayers() {
    return listOfPlayers;
  }
}