import 'package:flutter/material.dart';

class ButtonMain extends StatelessWidget {
  final Function() onPressed;
  final String text;

  const ButtonMain({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const myStyle = TextStyle(
      fontSize: 20,
      color: Colors.white70,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.black, Colors.red]),
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: myStyle,
            ),
          ),
        ),
      ),
    );
  }
}
