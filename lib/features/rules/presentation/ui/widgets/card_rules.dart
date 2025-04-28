import 'package:flutter/material.dart';

class CardRules extends StatelessWidget {
  final String title;
  final String? text;
  final int stepNumber;
  final bool isLast;
  final bool showNumber;
  const CardRules(
      {super.key,
      required this.title,
      this.text,
      required this.stepNumber,
      this.isLast = false,
      this.showNumber = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xFF600010),
              child: showNumber
                  ? Text(
                      '$stepNumber',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Icon(
                      Icons.star_border_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF600010),
                ),
              ),
            ),
          ],
        ),
        // Нижняя линия
        if (!isLast && text != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Color(0xFF600010), width: 3),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 36.0),
                    child: Text(
                      text!,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
