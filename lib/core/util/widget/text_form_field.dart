import 'package:flutter/material.dart';
class MyFormField extends StatelessWidget {
 final TextEditingController ?controller;
   TextInputType ?type;
   Widget? suffixIcon;
  final String label;

  MyFormField(
      {Key? key,
    //    this.widget,
         this.controller,
         this.type,
        this.suffixIcon,
        required this.label,

      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: type,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  suffixIcon: suffixIcon ,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black
                    ),
                    borderRadius: BorderRadius.circular(
                        10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
