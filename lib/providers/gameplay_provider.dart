import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Gameplay with ChangeNotifier {
  //Firestore Instance
  var db = FirebaseFirestore.instance.collection("musical_genres");

  Map _gameplayMap = {};
  // String _genreName = "";

  Future<void> getGameplayData() async {

    // First Generate Random Genre Picker
    QuerySnapshot qs =
        await db.get(); //Query of all he documents in the collection
    int documentsCount = qs.size;

    // Generate a Random Number to pick a document
    int randomSelector = Random().nextInt(documentsCount);

    //Generate Gameplay map
    DocumentSnapshot docSnap = await db.doc("$randomSelector").get();
    _gameplayMap = docSnap.data() as Map;

    //Delay for 5sec so loading animation can play
    await Future.delayed(const Duration(seconds: 1));
  }

  String get genreName => _gameplayMap["genreName"];
  String get genreDesc => _gameplayMap["genreDescription"];
  String get genreExample => _gameplayMap["generalExample"];

  String getEasyFilter() {
    List easyFilterArray = _gameplayMap["easyFilters"];

    // Generate a Random Number to pick a filter
    int selector = Random().nextInt(easyFilterArray.length);

    return easyFilterArray[selector];
  }

  String getMediumFilter() {
    List mediumFilterArray = _gameplayMap["mediumFilters"];

    // Generate a Random Number to pick a filter
    int selector = Random().nextInt(mediumFilterArray.length);

    return mediumFilterArray[selector];
  }

  String getHardFilter() {
    List hardFilterArray = _gameplayMap["hardFilters"];

    // Generate a Random Number to pick a filter
    int selector = Random().nextInt(hardFilterArray.length);

    return hardFilterArray[selector];
  }

}
