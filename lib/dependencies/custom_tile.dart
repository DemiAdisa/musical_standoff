import 'package:flutter/material.dart';
import 'color_list.dart';

class CustomTile extends StatelessWidget {
  final String mainText;
  final String subText;
  final Function callback;

  CustomTile({
    required this.mainText,
    required this.subText,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: ColorList().yellow(),
      ),
      child: ListTile(
        title: Text(mainText),
        subtitle: Text(subText),
        trailing: const Icon(Icons.arrow_circle_right_outlined),
        onTap: () {
          callback();
        },
      ),
    );
  }
}
