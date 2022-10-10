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


    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorList().yellow(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)),
      ),
      onPressed: () {
        buttonCallback();
      },
      child: Text(
        buttonText,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );

    // Original Button Implementation
    // return GestureDetector(
    //   onTap: () {
    //     buttonCallback();
    //   },
    //   child: Container(
    //     padding: EdgeInsets.all(_deviceWidth! * 0.03),
    //     decoration: BoxDecoration(
    //       color: ColorList().yellow(),
    //       boxShadow: const [
    //         BoxShadow(blurRadius: 15.0),
    //       ],
    //       borderRadius: const BorderRadius.all(
    //         Radius.circular(20),
    //       ),
    //     ),
    //     child: Text(
    //       buttonText,
    //       style: const TextStyle(fontWeight: FontWeight.bold),
    //     ),
    //   ),
    // );
  }
}
