import 'package:flutter/material.dart';

class ButtonOfText extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
   Color? color;
   Color ?buttonColor;
   ButtonOfText(
      {Key? key,
      required this.text,
      required this.onClick,
       this.color,
      this.buttonColor
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
        color: buttonColor,
      ),
      height: 50,
      width: double.infinity,

      child: TextButton(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          onPressed: () {
            onClick();
          },
          child: Text(
            text,
            style: TextStyle(color: color),
          )),
    );
  }
}
