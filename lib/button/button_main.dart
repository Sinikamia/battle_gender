import 'package:flutter/material.dart';

class ButtonMain extends StatelessWidget {
  final Function() onPressed;

  ButtonMain({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
          child: const Center(
            child: Text(
              "Новая игра",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
