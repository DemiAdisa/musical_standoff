import 'package:flutter/material.dart';

import 'color_list.dart';

class TextBox extends StatelessWidget {

  final String boxText;
  late double? _deviceWidth;
  late double? _deviceHeight;

  TextBox({required this.boxText});

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    _deviceHeight = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      padding: EdgeInsets.all(_deviceWidth! * 0.03),
      decoration: BoxDecoration(
        color: ColorList().yellow(),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 10.0,
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(3.0),
        ),
      ),
      child: Text(
        boxText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          // fontFamily:
        ),),
    );
  }
}
