import 'package:flutter/material.dart';

import 'color_list.dart';

class UnderlineText extends StatelessWidget {

  final String txtContent;
  UnderlineText({required this.txtContent});

  @override
  Widget build(BuildContext context) {
    return Text(
      txtContent,
      style: TextStyle(
        fontSize: 25,
        color: Colors.transparent,
        shadows: const [Shadow(offset: Offset(0, -5), color: Colors.white)],
        decoration: TextDecoration.underline,
        decorationThickness: 3,
        decorationColor: ColorList().yellow(),
      ),
    );
  }
}
