import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/color_list.dart';

/// This is a class which will act as a reusable button for the App
/// Its parameters are a String (buttontext) for the Buttons text and
/// a Callback function (buttonCallback) to be executed when the button
/// has been pressed/tapped
class CapsuleButton extends StatelessWidget {
  final String buttonText;
  final Function buttonCallback;
  late double? _deviceWidth;
  // late double? _deviceHeight;



  CapsuleButton({
    required this.buttonText,
    required this.buttonCallback,
  });

  @override
  Widget build(BuildContext context) {

    _deviceWidth = MediaQuery.of(context).size.width;
    // _deviceHeight = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        buttonCallback();
      },
      child: Container(
        padding: EdgeInsets.all(_deviceWidth! * 0.03),
        decoration: BoxDecoration(
          color: ColorList().getColor2(),
          boxShadow: const [
            BoxShadow(blurRadius: 20.0),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Text(buttonText),
      ),
    );
  }
}
