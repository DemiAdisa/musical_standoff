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
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Row(
                      children: const [
                        Icon(Icons.crisis_alert),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Do you want to go back?")
                      ],
                    ),
                    content:
                        const Text("You will lose your current selections."),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('CANCEL'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          //Pop off the Dialog AND THE SCREEN
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('GO BACK'),
                      ),
                    ],
                  ));
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
