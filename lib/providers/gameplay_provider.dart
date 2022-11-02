import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Gameplay with ChangeNotifier {

  //Firestore Instance
  var db = FirebaseFirestore.instance;
  final String _genre = "";
  final String _easyFilter = "";
  final String _mediumFilter = "";
  final String _hardFilter = "";


}