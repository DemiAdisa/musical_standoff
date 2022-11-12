import 'package:flutter/material.dart';

import 'color_list.dart';

class RegularBackButton extends StatelessWidget {

  late double? _deviceHeight;
  RegularBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.only(
        top: _deviceHeight! * 0.035,
    ),
    child: FloatingActionButton(
      backgroundColor: ColorList().yellow(),
      mini: true,
      child: Icon(
        Icons.arrow_back_ios_new,
        color: ColorList().black(),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ));
  }
}
