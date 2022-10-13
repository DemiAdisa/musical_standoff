import 'package:flutter/material.dart';

import 'color_list.dart';

class TextBox extends StatelessWidget {
  final String boxText;
  late double? _deviceWidth;
  late double? _deviceHeight;

  TextBox({required this.boxText});

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return Text(
      boxText.toUpperCase(),
      style: TextStyle(
        fontSize: 30,
        color: Colors.transparent,
        shadows: const [Shadow(offset: Offset(0, -5), color: Colors.white)],
        decoration: TextDecoration.underline,
        decorationThickness: 3,
        decorationColor: ColorList().yellow(),
      ),
    );
  }
}
