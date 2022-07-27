import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  final String largeText;
  const LargeText({
    Key? key,
    required this.largeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      largeText,
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 24),
    );
  }
}
