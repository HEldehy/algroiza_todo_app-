import 'package:flutter/material.dart';

import 'custom_large_text.dart';

class CustomCheckStatus extends StatefulWidget {
  final Color borderColor;
  final String taskDescription;

   CustomCheckStatus({Key? key,
    required this.borderColor,
    required this.taskDescription

  }) : super(key: key);

  @override
  State<CustomCheckStatus> createState() => _CustomCheckStatusState();
}

class _CustomCheckStatusState extends State<CustomCheckStatus> {
  bool _isSelected = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isSelected = !_isSelected;
            });
          },
          child:
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastLinearToSlowEaseIn,
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: _isSelected ? Colors.transparent : Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color:_isSelected? widget.borderColor:Colors.red,
                width: 2
              )
            ),
            child: _isSelected
                ? null:const Icon(
              Icons.check,
              color: Colors.white,
              size: 25,

            ),
          ),
        ),
        const SizedBox(width: 20,),
        LargeText(largeText: widget.taskDescription,)
      ],
    );
  }
}
