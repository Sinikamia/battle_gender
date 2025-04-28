import 'package:flutter/material.dart';

class ButtonAnswer extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color colorsButton;
  const ButtonAnswer(
      {super.key,
      required this.text,
      required this.onTap,
      required this.colorsButton});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double widthButton = (width - 30) / 2;
    const myStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
    return Container(
      width: widthButton,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorsButton,
        ),
        onPressed: onTap,
        child: Text(text, style: myStyle1),
      ),
    );
  }
}
