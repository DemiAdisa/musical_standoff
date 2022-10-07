import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/color_list.dart';

class CustomBackButton extends StatelessWidget {
  late double? _deviceHeight;

  CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        top: _deviceHeight! * 0.015,
      ),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: ColorList().yellow(),
        mini: true,
        child: Icon(
          Icons.arrow_back_ios_new,
          color: ColorList().black(),
        ),
      ),
    );
  }
}
