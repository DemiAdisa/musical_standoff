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

  void removePlayer(Player playerObj) {
    _listOfPlayers.remove(playerObj);
    notifyListeners();
  }

  void resetList() {
    _listOfPlayers = [];
    notifyListeners();
  }

  List<Player> getListOfPlayers() {
    //Sort List by Player Score
    _listOfPlayers.sort((a, b) => a.getScore.compareTo(b.getScore));

    final reversedList = _listOfPlayers.reversed.toList();

    //Return List
    return reversedList;
  }

  void updatePlayerScore({required String pName, required int filterType}) {
    for (Player p in _listOfPlayers) {
      if (p.playerName == pName) {
        if (filterType == 0) {
          p.incrementScore();
        } else if (filterType == 1) {
          p.incrementScoreBy2();
        } else if (filterType == 2) {
          p.incrementScoreBy3();
        } else {
          p.incrementScoreBy4();
          debugPrint(" ${p.playerName} has score: ${p.getScore}");
        }
      }
    }

    notifyListeners();
  }

  Player getWinner() {
    int maxScore = 0;
    Player? tempPlayer;
    for (Player plyr in _listOfPlayers) {
      if (plyr.getScore > maxScore) {
        maxScore = plyr.getScore;
        tempPlayer = plyr;
      }
    }

    return tempPlayer!;
  }
}
