import 'package:flutter/material.dart';

class CardCoupQuestions extends StatelessWidget {
  final String text;
  final double opacity;
  final double textOpacity;

  const CardCoupQuestions({
    super.key,
    required this.text,
    required this.opacity,
    required this.textOpacity,
  });

  @override
  Widget build(BuildContext context) {
    const myStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
    );
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        //image: DecorationImage(
        //image: const AssetImage('assets/paper.jpg'), fit: BoxFit.cover),
        color: Color(0xFF600010),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(seconds: 2),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                  image: AssetImage('assets/blur.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: textOpacity,
            duration: const Duration(seconds: 2),
            child: AnimatedDefaultTextStyle(
              style: TextStyle(
                color: textOpacity == 0.3
                    ? Colors.white.withOpacity(0.1)
                    : Colors.white,
              ),
              duration: const Duration(seconds: 2),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(text, textAlign: TextAlign.center, style: myStyle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
